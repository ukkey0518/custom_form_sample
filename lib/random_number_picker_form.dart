import 'package:custom_form_sample/random_number_picker.dart';
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
            );
          },
        );

  @override
  FormFieldState<int> createState() => FormFieldState();
}
