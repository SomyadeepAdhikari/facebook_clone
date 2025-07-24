import 'package:flutter/material.dart';

class GenderRadioTile extends StatelessWidget {
  final String title;
  final String value;
  final String? selectedValue;
  final Function(String? value) onChanged;
  const GenderRadioTile({
    super.key,
    required this.title,
    required this.value,
    this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          //style: const TextStyle(fontSize: 16.0),
        ),
        Radio.adaptive(
          value: value,
          groupValue: selectedValue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
