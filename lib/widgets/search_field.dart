import 'package:flutter/material.dart';
import 'package:hosta_app/theme/app_colors.dart';

class SearchField extends StatelessWidget {
  final String selectedCity;
  final VoidCallback onCityPickerPressed;

  const SearchField({
    super.key,
    required this.selectedCity,
    required this.onCityPickerPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return TextField(
      decoration: InputDecoration(
        hintText: 'Search a service...',
        hintStyle: TextStyle(
          color: isDark
              ? AppColors.white.withAlpha((255 * 0.7).toInt())
              : AppColors.dark.withAlpha((255 * 0.7).toInt()),
        ),
        prefixIcon: IconButton(
          icon: Icon(
            Icons.location_on,
            color: isDark ? AppColors.white : AppColors.dark,
          ),
          onPressed: onCityPickerPressed,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark
                ? AppColors.white.withAlpha((255 * 0.3).toInt())
                : AppColors.dark.withAlpha((255 * 0.3).toInt()),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark
                ? AppColors.white.withAlpha((255 * 0.3).toInt())
                : AppColors.dark.withAlpha((255 * 0.3).toInt()),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? AppColors.white : AppColors.dark,
          ),
        ),
        filled: true,
        fillColor: isDark
            ? AppColors.dark.withAlpha((255 * 0.1).toInt())
            : AppColors.white,
      ),
    );
  }
}
