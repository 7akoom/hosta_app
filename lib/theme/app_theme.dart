import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_input_decoration.dart';
import 'app_fonts.dart';

class AppTheme {
  static ThemeData getTheme(BuildContext context, bool isDark) {
    final locale = Localizations.maybeLocaleOf(context) ?? const Locale('en');
    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: AppColors.primaryBlue,
      textTheme: AppFonts.getTextTheme(locale),
      fontFamily: AppFonts.getFontFamily(locale),
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryBlue,
        brightness: isDark ? Brightness.dark : Brightness.light,
      ),
      inputDecorationTheme: isDark
          ? AppInputDecoration.dark
          : AppInputDecoration.light,
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.all(
          isDark ? AppColors.white : AppColors.primaryBlue,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: isDark ? AppColors.white : AppColors.primaryBlue,
          foregroundColor: isDark ? AppColors.dark : AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  static ThemeData getLightTheme(BuildContext context) =>
      getTheme(context, false);
  static ThemeData getDarkTheme(BuildContext context) =>
      getTheme(context, true);

  // Legacy static themes for backward compatibility
  @Deprecated('Use getLightTheme(context) instead')
  static final ThemeData defaultLightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryBlue,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
      brightness: Brightness.light,
    ),
    inputDecorationTheme: AppInputDecoration.light,
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(AppColors.primaryBlue),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryBlue,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
  );

  @Deprecated('Use getDarkTheme(context) instead')
  static final ThemeData defaultDarkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryBlue,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryBlue,
      brightness: Brightness.dark,
    ),
    inputDecorationTheme: AppInputDecoration.dark,
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(AppColors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.dark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
  );
}
