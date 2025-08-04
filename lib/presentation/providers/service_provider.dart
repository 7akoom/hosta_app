import 'package:flutter/foundation.dart';
import 'package:hosta_app/data/models/service_model.dart';
import 'package:hosta_app/data/models/category_model.dart';
import 'package:hosta_app/data/repositories/service_repository.dart';
import 'package:hosta_app/core/errors/network_exception.dart';

class ServiceProvider extends ChangeNotifier {
  final ServiceRepository _serviceRepository;
  List<ServiceModel> _services = [];
  List<CategoryModel> _categories = [];
  bool _isLoading = false;
  String? _error;

  ServiceProvider(this._serviceRepository);

  List<ServiceModel> get services => _services;
  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadServices({String? categoryId}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _services = await _serviceRepository.getServices(categoryId: categoryId);
      _error = null;
    } catch (e) {
      _error = e is NetworkException ? e.message : e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCategories() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _categories = await _serviceRepository.getCategories();
      _error = null;
    } catch (e) {
      _error = e is NetworkException ? e.message : e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<ServiceModel> getServiceById(String serviceId) async {
    try {
      return await _serviceRepository.getServiceById(serviceId);
    } catch (e) {
      throw e is NetworkException ? e : NetworkException(e.toString());
    }
  }

  Future<CategoryModel> getCategoryById(String categoryId) async {
    try {
      return await _serviceRepository.getCategoryById(categoryId);
    } catch (e) {
      throw e is NetworkException ? e : NetworkException(e.toString());
    }
  }
}
