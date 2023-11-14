import 'dart:math';

import 'package:flutter/material.dart';

class RandomNumberPicker extends StatefulWidget {
  const RandomNumberPicker({
    super.key,
    required this.values,
    this.initialValue,
    this.onChanged,
    this.errorText,
  });

  final List<int> values;
  final int? initialValue;
  final ValueChanged<int>? onChanged;
  final String? errorText;

  @override
  State<RandomNumberPicker> createState() => _RandomNumberPickerState();
}

class _RandomNumberPickerState extends State<RandomNumberPicker> {
  late int? _currentValue = widget.initialValue;

  void _setValue() {
    final newValue = widget.values[Random().nextInt(widget.values.length)];
    setState(() => _currentValue = newValue);
    if (widget.onChanged != null) {
      widget.onChanged!(newValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: _setValue,
          child: Container(
            width: 100,
            height: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
            ),
            child: Text(_currentValue?.toString() ?? ''),
          ),
        ),
        if (widget.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              widget.errorText!,
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          )
      ],
    );
  }
}
