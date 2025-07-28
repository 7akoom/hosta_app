import 'package:flutter/material.dart';
import 'package:hosta_app/theme/app_colors.dart';
import 'dart:ui';

Future<void> showCityPickerDialog({
  required BuildContext context,
  required List<String> cities,
  required String selectedCity,
  required Function(String) onSelected,
}) async {
  final isDark = Theme.of(context).brightness == Brightness.dark;

  await showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
        child: AlertDialog(
          backgroundColor: isDark ? AppColors.dark : Colors.white,
          title: Text(
            "Select City",
            style: TextStyle(color: isDark ? AppColors.white : AppColors.dark),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: cities.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: isDark
                    ? AppColors.white.withAlpha((255 * 0.2).toInt())
                    : AppColors.dark.withAlpha((255 * 0.2).toInt()),
              ),
              itemBuilder: (context, index) {
                final city = cities[index];
                return ListTile(
                  title: Text(
                    city,
                    style: TextStyle(
                      color: isDark ? AppColors.white : AppColors.dark,
                    ),
                  ),
                  onTap: () {
                    onSelected(city);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ),
      );
    },
  );
}
