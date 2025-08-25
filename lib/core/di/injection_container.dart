import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hosta_app/data/datasources/api_service.dart';
import 'package:hosta_app/data/datasources/notification_service.dart';
import 'package:hosta_app/data/repositories/auth_repository.dart';
import 'package:hosta_app/data/repositories/provider_repository.dart';
import 'package:hosta_app/data/repositories/service_repository.dart';
import 'package:hosta_app/presentation/providers/auth_provider.dart';
import 'package:hosta_app/presentation/providers/provider_provider.dart';
import 'package:hosta_app/presentation/providers/service_provider.dart';
import 'package:hosta_app/presentation/providers/category_provider.dart';
import 'package:hosta_app/presentation/providers/chat_provider.dart';
import 'package:hosta_app/presentation/providers/feedback_provider.dart';
import 'package:hosta_app/presentation/providers/app_settings_provider.dart';
import 'package:hosta_app/presentation/providers/favorite_provider.dart';
import 'package:hosta_app/presentation/providers/notification_provider.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Data Sources
  getIt.registerLazySingleton<ApiService>(
    () => ApiService(getIt<SharedPreferences>()),
  );
  getIt.registerLazySingleton<NotificationService>(() => NotificationService());

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<ProviderRepository>(
    () => ProviderRepository(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<ServiceRepository>(
    () => ServiceRepository(getIt<ApiService>()),
  );

  // Providers
  getIt.registerFactory<NotificationProvider>(
    () => NotificationProvider(getIt<NotificationService>()),
  );
  getIt.registerFactory<AppSettingsProvider>(
    () => AppSettingsProvider(getIt<SharedPreferences>()),
  );
  getIt.registerFactory<AuthProvider>(
    () => AuthProvider(getIt<AuthRepository>()),
  );
  getIt.registerFactory<ProviderProvider>(
    () => ProviderProvider(getIt<ProviderRepository>()),
  );
  getIt.registerFactory<ServiceProvider>(
    () => ServiceProvider(getIt<ServiceRepository>()),
  );
  getIt.registerFactory<CategoryProvider>(
    () => CategoryProvider(getIt<ApiService>()),
  );
  getIt.registerFactory<ChatProvider>(() => ChatProvider());
  getIt.registerFactory<FeedbackProvider>(
    () => FeedbackProvider(getIt<ApiService>()),
  );
  getIt.registerFactory<FavoriteProvider>(
    () => FavoriteProvider(getIt<ProviderRepository>()),
  );
}
