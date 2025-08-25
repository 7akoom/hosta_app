import 'package:flutter/material.dart';

class LanguageBadges extends StatelessWidget {
  final List<String>? languages;
  final bool isDark;
  final double fontSize;
  final double padding;
  final double borderRadius;

  const LanguageBadges({
    super.key,
    required this.languages,
    required this.isDark,
    this.fontSize = 10,
    this.padding = 4,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    if (languages == null || languages!.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      spacing: 4,
      runSpacing: 4,
      children: languages!.map((language) {
        return _LanguageBadge(
          language: language,
          isDark: isDark,
          fontSize: fontSize,
          padding: padding,
          borderRadius: borderRadius,
        );
      }).toList(),
    );
  }
}

class _LanguageBadge extends StatelessWidget {
  final String language;
  final bool isDark;
  final double fontSize;
  final double padding;
  final double borderRadius;

  const _LanguageBadge({
    required this.language,
    required this.isDark,
    required this.fontSize,
    required this.padding,
    required this.borderRadius,
  });

  String _getLanguageDisplayName(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ku':
      case 'kurdish':
        return 'کوردی';
      case 'ar':
      case 'arabic':
        return 'العربية';
      case 'en':
      case 'english':
        return 'English';
      default:
        return languageCode;
    }
  }

  Color _getLanguageColor(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'ku':
      case 'kurdish':
        return const Color(0xFF4CAF50); // أخضر
      case 'ar':
      case 'arabic':
        return const Color(0xFF2196F3); // أزرق
      case 'en':
      case 'english':
        return const Color(0xFFFF9800); // برتقالي
      default:
        return const Color(0xFF9E9E9E); // رمادي
    }
  }

  @override
  Widget build(BuildContext context) {
    final displayName = _getLanguageDisplayName(language);
    final color = _getLanguageColor(language);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        displayName,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
