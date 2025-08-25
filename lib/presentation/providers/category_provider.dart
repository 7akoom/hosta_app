import 'package:flutter/foundation.dart';
import '../../data/models/category_model.dart';
import '../../data/datasources/api_service.dart';
import '../../core/errors/network_exception.dart';

class CategoryProvider extends ChangeNotifier {
  List<CategoryModel> _categories = [];
  bool _isLoading = false;
  String? _error;
  // ignore: unused_field - Will be used when backend is ready
  final ApiService _apiService;

  CategoryProvider(this._apiService);

  // Getters
  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Clear error
  void clearError() {
    if (_error != null) {
      _error = null;
      notifyListeners();
    }
  }

  // Load categories
  Future<void> loadCategories() async {
    if (_isLoading) return; // Prevent multiple simultaneous loads

    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // TODO: Replace with actual API call when backend is ready
      // For now, use static data with minimal delay
      await Future.delayed(
        const Duration(milliseconds: 100), // Reduced delay for better UX
      );

      final newCategories = _getStaticCategories();

      // Only notify if data actually changed
      if (!listEquals(_categories, newCategories)) {
        _categories = newCategories;
        _isLoading = false;
        notifyListeners();
      } else {
        _isLoading = false;
        notifyListeners();
      }
    } catch (e) {
      _error = e is NetworkException ? e.message : 'An error occurred';
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get category by ID
  CategoryModel? getCategoryById(String categoryId) {
    try {
      return _categories.firstWhere((category) => category.id == categoryId);
    } catch (e) {
      return null;
    }
  }

  // Search categories
  List<CategoryModel> searchCategories(String query) {
    if (query.isEmpty) return _categories;

    return _categories.where((category) {
      return category.name.toLowerCase().contains(query.toLowerCase()) ||
          (category.description?.toLowerCase().contains(query.toLowerCase()) ??
              false);
    }).toList();
  }

  // Clear categories
  void clearCategories() {
    if (_categories.isNotEmpty) {
      _categories = [];
      notifyListeners();
    }
  }

  // Refresh categories
  Future<void> refreshCategories() async {
    await loadCategories();
  }

  // Static data generation
  List<CategoryModel> _getStaticCategories() {
    final now = DateTime.now();

    return [
      CategoryModel(
        id: '1',
        name: 'Cleaning',
        description: 'Professional cleaning services for your home and office',
        icon: 'assets/icons/cleaning.svg',
        isActive: true,
        serviceCount: 15,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: '2',
        name: 'Plumbing',
        description: 'Expert plumbing and pipe repair services',
        icon: 'assets/icons/plumber.svg',
        isActive: true,
        serviceCount: 12,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: '3',
        name: 'Electrical',
        description: 'Licensed electrical contractors and repair services',
        icon: 'assets/icons/electrican.svg',
        isActive: true,
        serviceCount: 8,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: '4',
        name: 'Painting',
        description: 'Professional painting and decorating services',
        icon: 'assets/icons/painting.svg',
        isActive: true,
        serviceCount: 10,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: '5',
        name: 'Gardening',
        description: 'Landscape design and garden maintenance services',
        icon: 'assets/icons/gardining.svg',
        isActive: true,
        serviceCount: 6,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: '6',
        name: 'Moving',
        description: 'Professional moving and relocation services',
        icon: 'assets/icons/homerepair.svg',
        isActive: true,
        serviceCount: 4,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: '7',
        name: 'Babysitting',
        description: 'Professional childcare and babysitting services',
        icon: 'assets/icons/babysitting.svg',
        isActive: true,
        serviceCount: 20,
        createdAt: now,
        updatedAt: now,
      ),
      CategoryModel(
        id: '8',
        name: 'Car Wash',
        description: 'Professional car washing and detailing services',
        icon: 'assets/icons/carwash.svg',
        isActive: true,
        serviceCount: 7,
        createdAt: now,
        updatedAt: now,
      ),
    ];
  }
}
