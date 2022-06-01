enum ApiExceptionType { network, other }

class ApiException implements Exception {
  final ApiExceptionType exceptionType;
  final String message;
  ApiException(this.exceptionType, [this.message = 'ApiException']);
}
