import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' show log;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hosta_app/core/di/injection_container.dart' as di;
import 'package:hosta_app/theme/app_theme.dart';
import 'package:hosta_app/routes/app_routes.dart';
import 'package:hosta_app/presentation/providers/app_provider.dart';
import 'package:hosta_app/presentation/providers/notification_provider.dart';
import 'package:hosta_app/presentation/providers/app_settings_provider.dart';
import 'package:hosta_app/presentation/providers/auth_provider.dart';
import 'package:hosta_app/presentation/providers/provider_provider.dart';
import 'package:hosta_app/presentation/providers/service_provider.dart';
import 'package:hosta_app/presentation/providers/favorite_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependencies
  await di.initializeDependencies();

  // Get initial route based on user status
  final prefs = await SharedPreferences.getInstance();

  // في وضع التصحيح، نقوم بمسح التفضيلات
  if (kDebugMode) {
    await prefs.clear();
    log('Cleared all preferences', name: 'AppInit');
  }

  final hasLanguage = prefs.getString('selected_language') != null;
  final hasToken = prefs.getString('access_token') != null;

  // تسجيل القيم للتحقق في وضع التصحيح
  log(
    'Initial app state - Language: $hasLanguage, Token: $hasToken',
    name: 'AppInit',
  );

  String initialRoute;
  if (!hasLanguage) {
    // First time user - show language selection
    initialRoute = '/';
  } else if (hasToken) {
    // Logged in user - go directly to home
    initialRoute = '/home';
  } else {
    // Has language but no token - go to home as guest
    initialRoute = '/home';
  }

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => di.getIt<NotificationProvider>(),
          ),
          ChangeNotifierProvider(
            create: (_) => di.getIt<AppSettingsProvider>(),
          ),
          ChangeNotifierProvider(create: (_) => di.getIt<AuthProvider>()),
          ChangeNotifierProvider(create: (_) => di.getIt<ProviderProvider>()),
          ChangeNotifierProvider(create: (_) => di.getIt<ServiceProvider>()),
          ChangeNotifierProvider(create: (_) => di.getIt<FavoriteProvider>()),
        ],
        child: Consumer<AppSettingsProvider>(
          builder: (context, appSettings, _) => MaterialApp(
            title: 'Hosta Services',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: appSettings.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            initialRoute: initialRoute,
            onGenerateRoute: AppRoutes.generateRoute,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
