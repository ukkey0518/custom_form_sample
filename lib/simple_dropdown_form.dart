import 'package:flutter/material.dart';

class SimpleDropdownForm<T> extends FormField<T> {
  SimpleDropdownForm({
    super.key,
    required List<T> values,
    T? initialValue,
    ValueChanged<T?>? onChanged,
    Widget Function(BuildContext context, T value)? itemBuilder,
    AutovalidateMode? autovalidateMode,
    bool? enabled,
    super.onSaved,
    super.validator,
    super.restorationId,
  }) : super(
          initialValue: initialValue,
          autovalidateMode: autovalidateMode ?? AutovalidateMode.disabled,
          enabled: enabled ?? true,
          builder: (state) {
            void onChangedHandler(T? value) {
              state.didChange(value);
              onChanged?.call(value);
            }

            return SimpleDropdown<T>(
              values: values,
              initialValue: initialValue,
              onChanged: onChangedHandler,
              enabled: enabled ?? true,
              errorText: state.errorText,
              itemBuilder: itemBuilder,
            );
          },
        );

  @override
  FormFieldState<T> createState() => FormFieldState();
}

class SimpleDropdown<T> extends StatefulWidget {
  const SimpleDropdown({
    super.key,
    required this.values,
    required this.onChanged,
    this.initialValue,
    this.itemBuilder,
    this.enabled = true,
    this.errorText,
  });

  final List<T> values;
  final T? initialValue;
  final Widget Function(BuildContext context, T value)? itemBuilder;
  final ValueChanged<T?>? onChanged;

  final bool enabled;
  final String? errorText;

  @override
  State<SimpleDropdown<T>> createState() => _SimpleDropdownState<T>();
}

class _SimpleDropdownState<T> extends State<SimpleDropdown<T>> {
  late T? _currentValue = widget.initialValue;

  void setValue(T? value) {
    setState(() => _currentValue = value);
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        errorText: widget.errorText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.error),
        ),
      ),
      child: SizedBox(
        width: 200,
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<T>(
            value: _currentValue,
            isExpanded: true,
            underline: Container(),
            focusColor: Colors.transparent,
            onChanged: widget.enabled ? setValue : null,
            items: widget.values.map((value) {
              return DropdownMenuItem<T>(
                value: value,
                child: widget.itemBuilder?.call(context, value) ??
                    Text(value.toString()),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
