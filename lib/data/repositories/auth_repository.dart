import 'package:hosta_app/core/errors/network_exception.dart';
import 'package:hosta_app/data/datasources/api_service.dart';
import 'package:hosta_app/data/models/user_model.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<UserModel> signIn(String email, String password) async {
    try {
      final response = await _apiService.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      return UserModel.fromJson(response.data['user']);
    } catch (e) {
      throw NetworkException('Failed to sign in: ${e.toString()}');
    }
  }

  Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    try {
      final response = await _apiService.post(
        '/auth/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          if (phone != null) 'phone': phone,
        },
      );

      return UserModel.fromJson(response.data['user']);
    } catch (e) {
      throw NetworkException('Failed to sign up: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      await _apiService.post('/auth/logout', data: {});
    } catch (e) {
      throw NetworkException('Failed to sign out: ${e.toString()}');
    }
  }

  Future<UserModel> updateUserInfo({
    String? email,
    String? phone,
    String? oldPassword,
    String? newPassword,
  }) async {
    try {
      final response = await _apiService.put(
        '/auth/profile',
        data: {
          if (email != null) 'email': email,
          if (phone != null) 'phone': phone,
          if (oldPassword != null) 'old_password': oldPassword,
          if (newPassword != null) 'new_password': newPassword,
        },
      );

      return UserModel.fromJson(response.data['user']);
    } catch (e) {
      throw NetworkException('Failed to update user info: ${e.toString()}');
    }
  }

  Future<void> deleteAccount() async {
    try {
      await _apiService.delete('/auth/account', data: {});
    } catch (e) {
      throw NetworkException('Failed to delete account: ${e.toString()}');
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _apiService.post('/auth/reset-password', data: {'email': email});
    } catch (e) {
      throw NetworkException('Failed to reset password: ${e.toString()}');
    }
  }

  Future<void> verifyResetCode(String email, String code) async {
    try {
      await _apiService.post(
        '/auth/verify-reset-code',
        data: {'email': email, 'code': code},
      );
    } catch (e) {
      throw NetworkException('Failed to verify reset code: ${e.toString()}');
    }
  }
}
