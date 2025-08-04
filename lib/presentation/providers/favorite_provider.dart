import 'package:flutter/foundation.dart';
import 'package:hosta_app/data/models/favorite_model.dart';
import 'package:hosta_app/data/repositories/provider_repository.dart';
import 'package:hosta_app/core/errors/network_exception.dart';

class FavoriteProvider extends ChangeNotifier {
  final ProviderRepository _providerRepository;
  List<FavoriteModel> _favorites = [];
  bool _isLoading = false;
  String? _error;

  FavoriteProvider(this._providerRepository);

  List<FavoriteModel> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadFavorites() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _favorites = await _providerRepository.getFavoriteProviders();
      _error = null;
    } catch (e) {
      _error = e is NetworkException ? e.message : e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> toggleFavorite(String providerId) async {
    try {
      await _providerRepository.toggleFavorite(providerId);
      await loadFavorites(); // Reload favorites after toggle
      return _favorites.any((favorite) => favorite.providerId == providerId);
    } catch (e) {
      _error = e is NetworkException ? e.message : e.toString();
      notifyListeners();
      return false;
    }
  }

  bool isProviderFavorite(String providerId) {
    return _favorites.any((favorite) => favorite.providerId == providerId);
  }
}
