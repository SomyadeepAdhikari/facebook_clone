import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email cannot be empty';
  }
  final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  if (!emailRegex.hasMatch(value)) {
    return 'Invalid email format';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}

String? validateName(String? value) {
  final nameRegex = RegExp(r'^[a-zA-Z]+$');
  if (value == null || value.isEmpty) {
    return 'Name cannot be empty';
  } else if (value.length < 3) {
    return 'Name must be at least 3 characters long';
  } else if (!nameRegex.hasMatch(value)) {
    return 'Name must contain only letters';
  }
  return null;
}

final today = DateTime.now();
// 18 years ago
final initialDate = DateTime.now().subtract(const Duration(days: 365 * 18));

// User can be born anytime after 1900
final firstDate = DateTime(1900);
// User should be atleast 10 years old
final lastDate = DateTime.now().subtract(const Duration(days: 365 * 10));

Future<DateTime?> pickSimpleDate({
  required BuildContext context,
  required DateTime? date,
}) async {
  final dateTime = await DatePicker.showSimpleDatePicker(
    context,
    initialDate: date ?? initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    dateFormat: 'dd-MMMM-yyyy',
  );
  return dateTime;
}
