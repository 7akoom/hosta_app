import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppInputDecoration {
  static InputDecorationTheme light = InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.border, width: 2),
    ),
    floatingLabelStyle: const TextStyle(
      color: AppColors.primaryBlue,
      fontWeight: FontWeight.bold,
    ),
  );

  static InputDecorationTheme dark = InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.border, width: 2),
    ),
    floatingLabelStyle: const TextStyle(
      color: AppColors.white,
      fontWeight: FontWeight.bold,
    ),
  );
}

InputDecoration appInputDecoration(
  BuildContext context,
  String label, {
  Widget? suffixIcon,
}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return InputDecoration(
    labelText: label,
    suffixIcon: suffixIcon,
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
