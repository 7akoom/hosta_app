import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hosta_app/core/config/app_config.dart';

class AuthInterceptor extends Interceptor {
  final SharedPreferences _prefs;
  bool _isRefreshing = false;

  AuthInterceptor(this._prefs);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = _prefs.getString('access_token');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _isRefreshing = true;

      try {
        final refreshToken = _prefs.getString('refresh_token');
        if (refreshToken == null) {
          throw DioException(
            requestOptions: err.requestOptions,
            error: 'No refresh token available',
          );
        }

        // Create a new Dio instance for refresh token request
        final refreshDio = Dio(
          BaseOptions(
            baseUrl: AppConfig.apiBaseUrl,
            headers: {'Accept': 'application/json'},
          ),
        );

        final response = await refreshDio.post(
          '/api/${AppConfig.apiVersion}/auth/refresh',
          data: {'refresh_token': refreshToken},
        );

        final newToken = response.data['access_token'];
        await _prefs.setString('access_token', newToken);

        // Retry the original request with the new token
        final options = err.requestOptions;
        options.headers['Authorization'] = 'Bearer $newToken';

        final dio = Dio();
        final retryResponse = await dio.fetch(options);
        handler.resolve(retryResponse);
      } catch (e) {
        // Clear tokens and handle authentication failure
        await _prefs.remove('access_token');
        await _prefs.remove('refresh_token');
        handler.reject(err);
      } finally {
        _isRefreshing = false;
      }
    } else {
      handler.next(err);
    }
  }
}
