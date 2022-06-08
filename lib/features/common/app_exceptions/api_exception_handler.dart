import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:elementary/elementary.dart';
import 'package:places/features/common/app_exceptions/api_exception.dart';
import 'package:places/features/common/app_exceptions/exception_strings.dart';

ApiException apiExceptionHandle({
  required Object error,
  required ConnectivityResult connectivityResult,
  required ErrorHandler errorHandler,
}) {
  errorHandler.handleError(error);
  final exception = connectivityResult == ConnectivityResult.none
      ? ApiException(
          ApiExceptionType.network,
          ExceptionStrings.networkException,
        )
      : ApiException(
          ApiExceptionType.other,
          ExceptionStrings.otherApiException,
        );
  errorHandler.handleError(exception.message);
  return exception;
}
