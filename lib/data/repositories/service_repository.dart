import 'package:hosta_app/core/errors/network_exception.dart';
import 'package:hosta_app/data/datasources/api_service.dart';
import 'package:hosta_app/data/models/service_model.dart';
import 'package:hosta_app/data/models/category_model.dart';

class ServiceRepository {
  final ApiService _apiService;

  ServiceRepository(this._apiService);

  Future<List<ServiceModel>> getServices({String? categoryId}) async {
    try {
      final response = await _apiService.get(
        '/services',
        queryParameters: {if (categoryId != null) 'category_id': categoryId},
      );

      return (response.data['services'] as List)
          .map((json) => ServiceModel.fromJson(json))
          .toList();
    } catch (e) {
      throw NetworkException('Failed to get services: ${e.toString()}');
    }
  }

  Future<ServiceModel> getServiceById(String serviceId) async {
    try {
      final response = await _apiService.get('/services/$serviceId');
      return ServiceModel.fromJson(response.data['service']);
    } catch (e) {
      throw NetworkException('Failed to get service: ${e.toString()}');
    }
  }

  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _apiService.get('/categories');
      return (response.data['categories'] as List)
          .map((json) => CategoryModel.fromJson(json))
          .toList();
    } catch (e) {
      throw NetworkException('Failed to get categories: ${e.toString()}');
    }
  }

  Future<CategoryModel> getCategoryById(String categoryId) async {
    try {
      final response = await _apiService.get('/categories/$categoryId');
      return CategoryModel.fromJson(response.data['category']);
    } catch (e) {
      throw NetworkException('Failed to get category: ${e.toString()}');
    }
  }
}
