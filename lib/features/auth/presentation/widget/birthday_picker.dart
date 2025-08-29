import 'package:facebook_clone/core/constants/extension.dart';
import 'package:flutter/material.dart';

class BirthdayPicker extends StatelessWidget {
  const BirthdayPicker({super.key, required this.dateTime, required this.onPressed});
  final DateTime dateTime;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Birthday (${DateTime.now().year - dateTime.year} years old)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              dateTime.yMMMEd(),
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
