class AppConfig {
  static const String appName = 'Hosta Services';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const String apiBaseUrl = 'https://api.hosta.com';
  static const int apiTimeout = 30000; // 30 seconds
  static const String apiVersion = 'v1';

  // Cache Configuration
  static const int maxCacheAge = 7 * 24 * 60 * 60; // 7 days in seconds
  static const int maxCacheSize = 10 * 1024 * 1024; // 10MB

  // Pagination
  static const int defaultPageSize = 20;

  // Image Configuration
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const List<String> supportedImageTypes = ['jpg', 'jpeg', 'png'];

  // Chat Configuration
  static const int maxMessageLength = 1000;
  static const Duration typingTimeout = Duration(seconds: 5);

  // Validation Rules
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 32;
  static const int minNameLength = 2;
  static const int maxNameLength = 50;

  // Feature Flags
  static const bool enableChat = true;
  static const bool enableNotifications = true;
  static const bool enableLocationServices = true;

  // Error Messages
  static const String defaultErrorMessage =
      'Something went wrong. Please try again.';
  static const String networkErrorMessage =
      'Please check your internet connection.';
  static const String sessionExpiredMessage =
      'Your session has expired. Please sign in again.';

  // Success Messages
  static const String profileUpdateSuccess = 'Profile updated successfully.';
  static const String passwordResetSuccess =
      'Password reset email sent successfully.';
  static const String feedbackSubmitSuccess = 'Thank you for your feedback!';

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 350);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);
}
