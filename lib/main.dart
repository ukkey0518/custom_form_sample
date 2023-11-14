import 'package:custom_form_sample/random_number_picker_form.dart';
import 'package:custom_form_sample/simple_dropdown_form.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(home: Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    const values = [1, 2, 3, 4, 5, 11, 12, 13, 14, 15];
    var currentRandomNumberPickerValue = values[0];
    var currentSimpleDropdownValue = values[0];

    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RandomNumberPickerForm(
                values: values,
                initialValue: currentRandomNumberPickerValue,
                onChanged: (value) => currentRandomNumberPickerValue = value,
                validator: (value) {
                  if (value == null) {
                    return 'Please select a value.';
                  }
                  if (value % 2 == 0) {
                    return 'Even numbers are not allowed.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SimpleDropdownForm(
                values: values,
                initialValue: currentSimpleDropdownValue,
                onChanged: (value) => currentSimpleDropdownValue =
                    value ?? currentSimpleDropdownValue,
                validator: (value) {
                  if (value == null) {
                    return 'Please select a value.';
                  }
                  if (value % 1 == 0) {
                    return 'Odd numbers are not allowed.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    duration: const Duration(milliseconds: 300),
                    backgroundColor: Theme.of(context).primaryColor,
                    content: Text(
                        'Submitted!: $currentRandomNumberPickerValue, $currentSimpleDropdownValue'),
                  ));
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
