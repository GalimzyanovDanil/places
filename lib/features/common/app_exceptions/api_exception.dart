// ignore_for_file: public_member_api_docs, sort_constructors_first
enum ApiExceptionType { network, other }

class ApiException implements Exception {
  final ApiExceptionType exceptionType;
  final String message;
  ApiException(this.exceptionType, [this.message = 'ApiException']);
}
