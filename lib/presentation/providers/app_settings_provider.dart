import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

class AppSettingsProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  late bool _isDarkMode;
  late String _selectedLanguage;

  // Supported languages
  static const Map<String, String> supportedLanguages = {
    'en': 'English',
    'ar': 'العربية',
    'ku': 'کوردی',
  };

  AppSettingsProvider(this._prefs) {
    _initializeSettings();
    _setupThemeListener();
  }

  void _initializeSettings() {
    // Get system theme mode
    final platformDispatcher = PlatformDispatcher.instance;
    final brightness = platformDispatcher.platformBrightness;
    final systemIsDark = brightness == Brightness.dark;

    // Initialize with system theme if not set
    _isDarkMode = _prefs.getBool('isDarkMode') ?? systemIsDark;
    _selectedLanguage = _prefs.getString('selected_language') ?? 'en';

    // Validate language
    if (!supportedLanguages.containsKey(_selectedLanguage)) {
      _selectedLanguage = 'en';
      _prefs.setString('selectedLanguage', 'en');
    }
  }

  void _setupThemeListener() {
    // Listen for system theme changes
    PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
      // Only update if user hasn't explicitly set a theme
      if (!_prefs.containsKey('isDarkMode')) {
        _isDarkMode =
            PlatformDispatcher.instance.platformBrightness == Brightness.dark;
        notifyListeners();
      }
    };
  }

  bool get isDarkMode => _isDarkMode;
  String get selectedLanguage => _selectedLanguage;
  Map<String, String> get languages => supportedLanguages;

  Locale get locale => Locale(_selectedLanguage);

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  Future<void> setLanguage(String language) async {
    if (language != _selectedLanguage &&
        supportedLanguages.containsKey(language)) {
      _selectedLanguage = language;
      await _prefs.setString('selected_language', language);
      notifyListeners();
    }
  }
}
