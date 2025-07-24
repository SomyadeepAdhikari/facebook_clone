import 'package:facebook_clone/auth/presentation/widget/gender_radio_tile.dart';
import 'package:facebook_clone/core/constants/app_colors.dart';
import 'package:facebook_clone/core/constants/constants.dart';
import 'package:flutter/material.dart';

class GenderPicker extends StatelessWidget {
  const GenderPicker({super.key, this.gender, required this.onChanged});
  final String? gender;
  final Function(String? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Constants.defaultPadding,
      decoration: BoxDecoration(
        color: AppColors.darkWhiteColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          GenderRadioTile(
            title: 'Male',
            value: 'male',
            selectedValue: gender,
            onChanged: onChanged,
          ),
          GenderRadioTile(
            title: 'Female',
            value: 'female',
            selectedValue: gender,
            onChanged: onChanged,
          )
        ],
      ),
    );
  }
}