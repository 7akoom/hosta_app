abstract class Failure {
  final String message;
  final dynamic error;

  const Failure({required this.message, this.error});

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  final int? statusCode;

  const ServerFailure({required super.message, this.statusCode, super.error});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'Network connection failed'});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache operation failed'});
}

class ValidationFailure extends Failure {
  final Map<String, List<String>>? errors;

  const ValidationFailure({required super.message, this.errors});
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({super.message = 'Authentication failed'});
}

class AuthorizationFailure extends Failure {
  const AuthorizationFailure({super.message = 'You are not authorized'});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({super.message = 'Resource not found'});
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({super.message = 'An unexpected error occurred'});
}
