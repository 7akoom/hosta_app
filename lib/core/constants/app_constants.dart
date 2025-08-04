class AppConstants {
  // App Info
  static const String appName = 'Hosta Services';
  static const String appVersion = '1.0.0';
  
  // API Constants
  static const String apiBaseUrl = 'https://api.hosta.com';
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String selectedLanguageKey = 'selected_language';
  static const String selectedCityKey = 'selected_city';
  static const String isFirstTimeKey = 'is_first_time';
  
  // Default Values
  static const String defaultCity = 'Erbil';
  static const String defaultLanguage = 'en';
  
  // Pagination
  static const int pageSize = 10;
  static const int maxRetries = 3;
} 