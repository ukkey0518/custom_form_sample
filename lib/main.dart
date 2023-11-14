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

    var currentText = 'Hello';

    const numbers = [1, 2, 3, 4, 5, 11, 12, 13, 14, 15];
    var currentNumber = numbers[0];

    const colors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.yellow,
      Colors.purple,
    ];
    var currentColor = colors[0];

    return Scaffold(
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // テキスト入力欄
              SizedBox(
                width: 200,
                child: TextFormField(
                  initialValue: currentText,
                  onChanged: (value) => currentText = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '必須項目です。';
                    }
                    if (value.length <= 3) {
                      return '3文字以上入力してください。';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              // ランダム数字選択欄
              RandomNumberPickerForm(
                values: numbers,
                initialValue: currentNumber,
                onChanged: (value) => currentNumber = value,
                validator: (value) {
                  if (value == null) {
                    return '必須項目です。';
                  }
                  if (value % 2 == 0) {
                    return '偶数は選択できません。';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              // カラー選択欄
              SimpleDropdownForm(
                values: colors,
                initialValue: currentColor,
                onChanged: (value) => currentColor = value ?? currentColor,
                itemBuilder: (context, value) => Container(
                  width: 100,
                  height: 20,
                  color: value,
                ),
                validator: (value) {
                  if (value == null) {
                    return '必須項目です。';
                  }
                  if (value == Colors.red) {
                    return '赤は選択できません。';
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
                      'テキスト: $currentText, '
                      '数字: $currentNumber, '
                      'カラー: $currentColor',
                    ),
                  ));
                },
                child: const Text('確定'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
