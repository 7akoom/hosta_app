import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsProvider extends ChangeNotifier {
  final SharedPreferences _prefs;
  bool _isDarkMode;
  String _selectedLanguage;

  AppSettingsProvider(this._prefs)
    : _isDarkMode = _prefs.getBool('isDarkMode') ?? false,
      _selectedLanguage = _prefs.getString('selectedLanguage') ?? 'en';

  bool get isDarkMode => _isDarkMode;
  String get selectedLanguage => _selectedLanguage;

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    await _prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  Future<void> setLanguage(String language) async {
    if (language != _selectedLanguage) {
      _selectedLanguage = language;
      await _prefs.setString('selectedLanguage', language);
      notifyListeners();
    }
  }
}
