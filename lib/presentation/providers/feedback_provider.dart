import 'package:flutter/material.dart';
import 'package:hosta_app/data/models/feedback_model.dart';
import 'package:hosta_app/data/datasources/api_service.dart';
import 'package:hosta_app/core/errors/app_exception.dart';

class FeedbackProvider extends ChangeNotifier {
  final ApiService _apiService;
  bool _isLoading = false;
  String? _error;

  FeedbackProvider(this._apiService);

  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<bool> submitFeedback({
    required String providerId,
    required String bookingId,
    required int rating,
    String? comment,
  }) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // TODO: Replace with actual API call
      await _apiService.post(
        '/feedback',
        data: {
          'provider_id': providerId,
          'booking_id': bookingId,
          'rating': rating,
          if (comment != null && comment.isNotEmpty) 'comment': comment,
        },
      );

      _isLoading = false;
      notifyListeners();
      return true;
    } on AppException catch (e) {
      _error = e.message;
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      _error = 'An unexpected error occurred';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<List<FeedbackModel>> getProviderFeedbacks(String providerId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      // TODO: Replace with actual API call
      final response = await _apiService.get('/providers/$providerId/feedback');

      final feedbacks = (response.data as List)
          .map((json) => FeedbackModel.fromJson(json))
          .toList();

      _isLoading = false;
      notifyListeners();
      return feedbacks;
    } on AppException catch (e) {
      _error = e.message;
      _isLoading = false;
      notifyListeners();
      return [];
    } catch (e) {
      _error = 'An unexpected error occurred';
      _isLoading = false;
      notifyListeners();
      return [];
    }
  }

  Future<double> getProviderAverageRating(String providerId) async {
    try {
      // TODO: Replace with actual API call
      final response = await _apiService.get('/providers/$providerId/rating');

      return response.data['average_rating'].toDouble();
    } catch (e) {
      return 0.0;
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
