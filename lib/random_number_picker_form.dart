import 'dart:math';

import 'package:flutter/material.dart';

class RandomNumberPickerForm extends FormField<int> {
  RandomNumberPickerForm({
    super.key,
    required List<int> values,
    int? initialValue,
    ValueChanged<int>? onChanged,
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
            void onChangedHandler(int value) {
              state.didChange(value);
              onChanged?.call(value);
            }

            return RandomNumberPicker(
              values: values,
              initialValue: initialValue,
              onChanged: onChangedHandler,
              errorText: state.errorText,
              enabled: enabled ?? true,
            );
          },
        );

  @override
  FormFieldState<int> createState() => FormFieldState();
}

class RandomNumberPicker extends StatefulWidget {
  const RandomNumberPicker({
    super.key,
    required this.values,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.errorText,
  });

  final List<int> values;
  final int? initialValue;
  final ValueChanged<int>? onChanged;
  final bool enabled;
  final String? errorText;

  @override
  State<RandomNumberPicker> createState() => _RandomNumberPickerState();
}

class _RandomNumberPickerState extends State<RandomNumberPicker> {
  late int? _currentValue = widget.initialValue;

  void _setValue() {
    final newValue = widget.values[Random().nextInt(widget.values.length)];
    setState(() => _currentValue = newValue);
    widget.onChanged?.call(newValue);
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
        height: kMinInteractiveDimension,
        child: InkWell(
          onTap: widget.enabled ? _setValue : null,
          child: Container(
            alignment: Alignment.center,
            child: Text(
              _currentValue?.toString() ?? '',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).primaryColorDark,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
