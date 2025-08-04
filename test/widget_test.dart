import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import 'package:hosta_app/main.dart';
import 'package:hosta_app/data/datasources/api_service.dart';
import 'package:hosta_app/data/repositories/auth_repository.dart';
import 'package:hosta_app/data/repositories/provider_repository.dart';
import 'package:hosta_app/data/repositories/service_repository.dart';
import 'package:hosta_app/presentation/providers/notification_provider.dart';
import 'package:hosta_app/presentation/providers/app_settings_provider.dart';
import 'package:hosta_app/presentation/providers/auth_provider.dart';
import 'package:hosta_app/presentation/providers/provider_provider.dart';
import 'package:hosta_app/presentation/providers/service_provider.dart';
import 'package:hosta_app/presentation/providers/favorite_provider.dart';

void main() {
  setUp(() async {
    // Initialize SharedPreferences for testing
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();

    // Register dependencies
    final getIt = GetIt.instance;

    // Register SharedPreferences
    getIt.registerSingleton<SharedPreferences>(prefs);

    // Register ApiService
    getIt.registerSingleton<ApiService>(ApiService(prefs));

    // Register Repositories
    getIt.registerSingleton<AuthRepository>(
      AuthRepository(getIt<ApiService>()),
    );
    getIt.registerSingleton<ProviderRepository>(
      ProviderRepository(getIt<ApiService>()),
    );
    getIt.registerSingleton<ServiceRepository>(
      ServiceRepository(getIt<ApiService>()),
    );

    // Register Providers
    getIt.registerSingleton<NotificationProvider>(NotificationProvider());
    getIt.registerSingleton<AppSettingsProvider>(
      AppSettingsProvider(getIt<SharedPreferences>()),
    );
    getIt.registerSingleton<AuthProvider>(
      AuthProvider(getIt<AuthRepository>()),
    );
    getIt.registerSingleton<ProviderProvider>(
      ProviderProvider(getIt<ProviderRepository>()),
    );
    getIt.registerSingleton<ServiceProvider>(
      ServiceProvider(getIt<ServiceRepository>()),
    );
    getIt.registerSingleton<FavoriteProvider>(
      FavoriteProvider(getIt<ProviderRepository>()),
    );
  });

  tearDown(() {
    // Clean up GetIt instance after each test
    GetIt.instance.reset();
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp(initialRoute: '/'));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
