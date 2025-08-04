import 'package:flutter/material.dart';
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

  // Get initial route based on authentication status
  final prefs = di.getIt<SharedPreferences>();
  final selectedLang = prefs.getString('selected_language');
  final hasToken = prefs.getString('access_token') != null;

  runApp(
    MyApp(
      initialRoute: hasToken
          ? '/home'
          : (selectedLang == null ? '/' : '/signin'),
    ),
  );
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
