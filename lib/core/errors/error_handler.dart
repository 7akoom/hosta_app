import 'dart:io';
import 'package:dio/dio.dart';
import 'package:hosta_app/core/errors/failures.dart';
import 'package:hosta_app/core/config/app_config.dart';

class ErrorHandler {
  static Failure handleError(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is SocketException) {
      return NetworkFailure(message: AppConfig.networkErrorMessage);
    } else if (error is FormatException) {
      return UnexpectedFailure(message: 'Invalid data format');
    } else {
      return UnexpectedFailure(message: AppConfig.defaultErrorMessage);
    }
  }

  static Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure(message: 'Connection timeout');

      case DioExceptionType.badResponse:
        return _handleResponseError(error.response);

      case DioExceptionType.cancel:
        return UnexpectedFailure(message: 'Request cancelled');

      case DioExceptionType.unknown:
        if (error.error is SocketException) {
          return NetworkFailure(message: AppConfig.networkErrorMessage);
        }
        return UnexpectedFailure(
          message: error.message ?? AppConfig.defaultErrorMessage,
        );

      default:
        return UnexpectedFailure(message: AppConfig.defaultErrorMessage);
    }
  }

  static Failure _handleResponseError(Response? response) {
    if (response == null) {
      return UnexpectedFailure(message: AppConfig.defaultErrorMessage);
    }

    switch (response.statusCode) {
      case 400:
        final data = response.data;
        if (data is Map && data.containsKey('errors')) {
          return ValidationFailure(
            message: 'Validation failed',
            errors: Map<String, List<String>>.from(data['errors']),
          );
        }
        return ServerFailure(
          message: data['message'] ?? 'Bad request',
          statusCode: response.statusCode,
        );

      case 401:
        return AuthenticationFailure(
          message: response.data?['message'] ?? AppConfig.sessionExpiredMessage,
        );

      case 403:
        return AuthorizationFailure(
          message: response.data?['message'] ?? 'Access denied',
        );

      case 404:
        return NotFoundFailure(
          message: response.data?['message'] ?? 'Resource not found',
        );

      case 422:
        final data = response.data;
        if (data is Map && data.containsKey('errors')) {
          return ValidationFailure(
            message: 'Validation failed',
            errors: Map<String, List<String>>.from(data['errors']),
          );
        }
        return ServerFailure(
          message: data['message'] ?? 'Validation failed',
          statusCode: response.statusCode,
        );

      case 500:
      case 501:
      case 502:
      case 503:
        return ServerFailure(
          message: response.data?['message'] ?? 'Server error',
          statusCode: response.statusCode,
        );

      default:
        return ServerFailure(
          message: response.data?['message'] ?? AppConfig.defaultErrorMessage,
          statusCode: response.statusCode,
        );
    }
  }

  static String getErrorMessage(Failure failure) {
    if (failure is ValidationFailure && failure.errors != null) {
      final firstError = failure.errors!.values.first.first;
      return firstError;
    }
    return failure.message;
  }
}
