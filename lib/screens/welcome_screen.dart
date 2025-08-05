import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        ? const Color(0xFF222831)
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Choose a Language',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  const Text('|', style: TextStyle(color: Colors.white54)),
                  const SizedBox(width: 8),
                  const Text(
                    'اختر اللغة',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _langButton('EN'),
                  const SizedBox(width: 16),
                  _langButton('AR'),
                  const SizedBox(width: 16),
                  _langButton('KR'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _langButton(String code) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ElevatedButton(
      onPressed: () => _selectLanguage(code),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: isDark ? Colors.black : Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(code, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Future<void> _selectLanguage(String code) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // حفظ اللغة المختارة
      await prefs.setString('selected_language', code);

      if (!mounted) return;

      // التوجيه إلى الشاشة الرئيسية
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save language preference'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
