import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hosta_app/presentation/providers/app_settings_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hosta_app/generated/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark
        ? const Color(0xFF000000)
        : const Color(0xFF61A3FE);
    final logoAsset = 'assets/images/logo.svg';

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(logoAsset, fit: BoxFit.contain),
              const SizedBox(height: 48),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                children: [
                  Text(
                    AppLocalizations.of(context)?.select_language ??
                        'Select Language',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(height: 48),
              Consumer<AppSettingsProvider>(
                builder: (context, settings, _) => Column(
                  children: [
                    _langButton('en', 'English', settings),
                    const SizedBox(height: 16),
                    _langButton('ar', 'العربية', settings),
                    const SizedBox(height: 16),
                    _langButton('ku', 'کوردی', settings),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _langButton(String code, String label, AppSettingsProvider settings) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = settings.selectedLanguage == code;

    return ElevatedButton(
      onPressed: () => _selectLanguage(code),
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? (isDark ? Colors.white : Colors.white)
            : (isDark ? Colors.black : const Color(0xFF61A3FE)),
        foregroundColor: isSelected
            ? (isDark ? Colors.black : Colors.blue)
            : (isDark ? Colors.white : Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        minimumSize: const Size(200, 50),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 18,
        ),
      ),
    );
  }

  Future<void> _selectLanguage(String code) async {
    try {
      final settings = context.read<AppSettingsProvider>();
      await settings.setLanguage(code);

      // حفظ اللغة في SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('selected_language', code);

      if (!mounted) return;

      // التوجيه إلى الشاشة الرئيسية
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context)?.error_occurred ??
                'Failed to save language preference',
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
