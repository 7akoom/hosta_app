import 'package:hosta_app/core/errors/network_exception.dart';
import 'package:hosta_app/data/datasources/api_service.dart';
import 'package:hosta_app/data/models/provider_model.dart';
import 'package:hosta_app/data/models/service_model.dart';
import 'package:hosta_app/data/models/feedback_model.dart';
import 'package:hosta_app/data/models/favorite_model.dart';

class ProviderRepository {
  final ApiService _apiService;

  ProviderRepository(this._apiService);

  Future<List<ProviderModel>> getProviders({
    String? serviceId,
    String? categoryId,
    String? query,
  }) async {
    try {
      final response = await _apiService.get(
        '/providers',
        queryParameters: {
          if (serviceId != null) 'service_id': serviceId,
          if (categoryId != null) 'category_id': categoryId,
          if (query != null) 'q': query,
        },
      );

      return (response.data['providers'] as List)
          .map((json) => ProviderModel.fromJson(json))
          .toList();
    } catch (e) {
      throw NetworkException('Failed to get providers: ${e.toString()}');
    }
  }

  Future<ProviderModel> getProviderById(String providerId) async {
    try {
      final response = await _apiService.get('/providers/$providerId');
      return ProviderModel.fromJson(response.data['provider']);
    } catch (e) {
      throw NetworkException('Failed to get provider: ${e.toString()}');
    }
  }

  Future<List<ServiceModel>> getProviderServices(String providerId) async {
    try {
      final response = await _apiService.get('/providers/$providerId/services');
      return (response.data['services'] as List)
          .map((json) => ServiceModel.fromJson(json))
          .toList();
    } catch (e) {
      throw NetworkException(
        'Failed to get provider services: ${e.toString()}',
      );
    }
  }

  Future<void> submitFeedback({
    required String providerId,
    required String bookingId,
    required double rating,
    String? comment,
  }) async {
    try {
      await _apiService.post(
        '/providers/$providerId/feedback',
        data: {
          'booking_id': bookingId,
          'rating': rating,
          if (comment != null) 'comment': comment,
        },
      );
    } catch (e) {
      throw NetworkException('Failed to submit feedback: ${e.toString()}');
    }
  }

  Future<List<FeedbackModel>> getProviderFeedback(String providerId) async {
    try {
      final response = await _apiService.get('/providers/$providerId/feedback');
      return (response.data['feedback'] as List)
          .map((json) => FeedbackModel.fromJson(json))
          .toList();
    } catch (e) {
      throw NetworkException(
        'Failed to get provider feedback: ${e.toString()}',
      );
    }
  }

  Future<double> getProviderAverageRating(String providerId) async {
    try {
      final response = await _apiService.get('/providers/$providerId/rating');
      return response.data['average_rating'];
    } catch (e) {
      throw NetworkException('Failed to get provider rating: ${e.toString()}');
    }
  }

  Future<void> toggleFavorite(String providerId) async {
    try {
      await _apiService.post('/providers/$providerId/favorite', data: {});
    } catch (e) {
      throw NetworkException('Failed to toggle favorite: ${e.toString()}');
    }
  }

  Future<List<FavoriteModel>> getFavoriteProviders() async {
    try {
      final response = await _apiService.get('/providers/favorites');
      return (response.data['favorites'] as List)
          .map((json) => FavoriteModel.fromJson(json))
          .toList();
    } catch (e) {
      throw NetworkException(
        'Failed to get favorite providers: ${e.toString()}',
      );
    }
  }
}
