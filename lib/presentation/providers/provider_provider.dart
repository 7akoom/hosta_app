import 'package:flutter/foundation.dart';
import 'package:hosta_app/data/models/provider_model.dart';
import 'package:hosta_app/data/models/service_model.dart';
import 'package:hosta_app/data/repositories/provider_repository.dart';
import 'package:hosta_app/core/errors/network_exception.dart';

class ProviderProvider extends ChangeNotifier {
  final ProviderRepository _providerRepository;
  List<ProviderModel> _providers = [];
  bool _isLoading = false;
  String? _error;

  ProviderProvider(this._providerRepository);

  List<ProviderModel> get providers => _providers;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadProviders({
    String? serviceId,
    String? categoryId,
    String? query,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _providers = await _providerRepository.getProviders(
        serviceId: serviceId,
        categoryId: categoryId,
        query: query,
      );
      _error = null;
    } catch (e) {
      _error = e is NetworkException ? e.message : e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<ProviderModel> loadProviderById(String providerId) async {
    try {
      return await _providerRepository.getProviderById(providerId);
    } catch (e) {
      throw e is NetworkException ? e : NetworkException(e.toString());
    }
  }

  Future<List<ServiceModel>> loadProviderServices(String providerId) async {
    try {
      return await _providerRepository.getProviderServices(providerId);
    } catch (e) {
      throw e is NetworkException ? e : NetworkException(e.toString());
    }
  }

  Future<void> submitFeedback({
    required String providerId,
    required String bookingId,
    required double rating,
    String? comment,
  }) async {
    try {
      await _providerRepository.submitFeedback(
        providerId: providerId,
        bookingId: bookingId,
        rating: rating,
        comment: comment,
      );
    } catch (e) {
      throw e is NetworkException ? e : NetworkException(e.toString());
    }
  }

  Future<double> getProviderRating(String providerId) async {
    try {
      return await _providerRepository.getProviderAverageRating(providerId);
    } catch (e) {
      throw e is NetworkException ? e : NetworkException(e.toString());
    }
  }

  // Method to update providers list (used for sorting)
  void updateProviders(List<ProviderModel> newProviders) {
    _providers = newProviders;
    notifyListeners();
  }
}
