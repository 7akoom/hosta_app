import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/api_service.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/provider_repository.dart';
import '../../data/repositories/service_repository.dart';
import 'auth_provider.dart';
import 'category_provider.dart';
import 'service_provider.dart';
import 'provider_provider.dart';
import 'chat_provider.dart';

class AppProvider extends StatelessWidget {
  final Widget child;

  const AppProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        return MultiProvider(
          providers: [
            // SharedPreferences
            Provider<SharedPreferences>.value(value: snapshot.data!),

            // API Service
            Provider<ApiService>(
              create: (context) =>
                  ApiService(context.read<SharedPreferences>()),
            ),

            // Repositories
            Provider<AuthRepository>(
              create: (context) => AuthRepository(context.read<ApiService>()),
            ),
            Provider<ServiceRepository>(
              create: (context) =>
                  ServiceRepository(context.read<ApiService>()),
            ),
            Provider<ProviderRepository>(
              create: (context) =>
                  ProviderRepository(context.read<ApiService>()),
            ),

            // Auth Provider
            ChangeNotifierProvider<AuthProvider>(
              create: (context) => AuthProvider(context.read<AuthRepository>()),
            ),

            // Category Provider
            ChangeNotifierProvider<CategoryProvider>(
              create: (context) => CategoryProvider(context.read<ApiService>()),
            ),

            // Service Provider
            ChangeNotifierProvider<ServiceProvider>(
              create: (context) =>
                  ServiceProvider(context.read<ServiceRepository>()),
            ),

            // Provider Provider
            ChangeNotifierProvider<ProviderProvider>(
              create: (context) =>
                  ProviderProvider(context.read<ProviderRepository>()),
            ),

            // Chat Provider
            ChangeNotifierProvider<ChatProvider>(
              create: (context) => ChatProvider(),
            ),
          ],
          child: child,
        );
      },
    );
  }
}
