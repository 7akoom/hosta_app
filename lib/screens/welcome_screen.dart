import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
              SvgPicture.asset(
                logoAsset,
                //width: 100,
                //height: 120,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Choose a Language',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Text('|', style: TextStyle(color: Colors.white54)),
                  const SizedBox(width: 8),
                  Text('اختر اللغة', style: TextStyle(color: Colors.white)),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _langButton(context, 'EN'),
                  const SizedBox(width: 16),
                  _langButton(context, 'AR'),
                  const SizedBox(width: 16),
                  _langButton(context, 'KR'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _langButton(BuildContext context, String code) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/signup');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: isDark ? Colors.black : Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      child: Text(code, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
