import 'package:auth/core/theme.dart';
import 'package:flutter/material.dart';

class PrimaryTextfield extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;

  const PrimaryTextfield(
      {super.key,
      required this.labelText,
      this.controller,
      this.validator,
      this.obscureText = false,
      this.hintText = ''});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: AppColors.primary),
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary),
        ),
        hintText: hintText,
        labelText: labelText,
      ),
      obscureText: obscureText,
    );
  }
}
