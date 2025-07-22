import 'package:flutter/material.dart';
import 'app_colors.dart';

InputDecoration appInputDecoration(BuildContext context, String label) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return InputDecoration(
    labelText: label,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.border, width: 2),
    ),
    floatingLabelStyle: TextStyle(
      color: isDark ? AppColors.white : AppColors.primaryBlue,
      fontWeight: FontWeight.bold,
    ),
  );
}
