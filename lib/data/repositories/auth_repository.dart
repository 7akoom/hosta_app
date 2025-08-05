import 'package:hosta_app/core/errors/network_exception.dart';
import 'package:hosta_app/data/datasources/api_service.dart';
import 'package:hosta_app/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<UserModel> signIn(String email, String password) async {
    try {
      // TODO: Remove mock data when backend is ready
      await Future.delayed(
        const Duration(seconds: 1),
      ); // Simulate network delay

      // Mock user data
      final mockUser = UserModel(
        id: '1',
        name: email.split('@')[0], // Use email name as display name
        email: email,
        phone: '+1234567890',
        avatar: 'https://ui-avatars.com/api/?name=${email.split('@')[0]}',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        city: 'Erbil',
        address: 'Iraq',
      );

      // Generate a mock token
      final mockToken = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';

      // Save the token
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', mockToken);

      return mockUser;
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
      // TODO: Remove mock data when backend is ready
      await Future.delayed(
        const Duration(seconds: 1),
      ); // Simulate network delay

      // Mock user data
      final mockUser = UserModel(
        id: '1',
        name: name,
        email: email,
        phone: phone ?? '+1234567890',
        avatar: 'https://ui-avatars.com/api/?name=${Uri.encodeComponent(name)}',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        city: 'Erbil',
        address: 'Iraq',
      );

      // Generate a mock token
      final mockToken = 'mock_token_${DateTime.now().millisecondsSinceEpoch}';

      // Save the token
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', mockToken);

      return mockUser;
    } catch (e) {
      throw NetworkException('Failed to sign up: ${e.toString()}');
    }
  }

  Future<void> signOut() async {
    try {
      await _apiService.post('/auth/logout', data: {});

      // مسح التوكن
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');
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
