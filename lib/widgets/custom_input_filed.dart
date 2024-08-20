import 'package:flutter/material.dart';
import 'package:study_planner_fluter/constants/colors.dart';

class CustomInputFiled extends StatelessWidget {
  final TextEditingController controller;
  final String labeltext;
  final String? Function(String?)? validator;

  const CustomInputFiled({
    super.key,
    required this.controller,
    required this.labeltext,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          labelText: labeltext,
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: darkGreen),
              borderRadius: BorderRadius.circular(12.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: darkGreen),
              borderRadius: BorderRadius.circular(12.0)),
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 13.0, horizontal: 12.0),
        ),
      ),
    );
  }
}
