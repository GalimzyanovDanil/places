import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:elementary/elementary.dart';
import 'package:places/features/common/app_exceptions/api_exception.dart';
import 'package:places/features/common/app_exceptions/exception_strings.dart';
import 'package:places/features/common/service/geoposition_service.dart';
import 'package:places/features/places_list/domain/entity/place.dart';
import 'package:places/features/places_list/service/places_service.dart';

// TODO: cover with documentation
/// Default Elementary model for PlacesList module
class PlacesListModel extends ElementaryModel {
  final PlacesService _placesService;
  final ErrorHandler _errorHandler;
  final ConnectivityResult _connectivityResult;
  final GeopositionService _geopositionService;

  PlacesListModel({
    required ErrorHandler errorHandler,
    required PlacesService placesService,
    required ConnectivityResult connectivityResult,
    required GeopositionService geopositionService,
  })  : _placesService = placesService,
        _errorHandler = errorHandler,
        _connectivityResult = connectivityResult,
        _geopositionService = geopositionService,
        super(errorHandler: errorHandler);

  Future<List<Place>> getPlacesList(int count, [int offset = 0]) async {
    try {
      final List<Place> result;
      result = await _placesService.getPlacesList(count, offset);
      return result;
    } on Object catch (error) {
      _errorHandler.handleError(error);
      final exception = _connectivityResult == ConnectivityResult.none
          ? ApiException(
              ApiExceptionType.network, ExceptionStrings.networkException)
          : ApiException(
              ApiExceptionType.other, ExceptionStrings.otherApiException);
      _errorHandler.handleError(exception.message);
      throw exception;
    }
  }

  Future<GeopositionStatus> isCheckPermission() =>
      _geopositionService.checkPermission();

  Future<GeopositionStatus> requsetAndIsCheckPermission() =>
      _geopositionService.requsetAndCheckPermission();

  Future<bool> isLocationServiceEnabled() =>
      _geopositionService.isLocationServiceEnabled();

  Future<void> openSettings() => _geopositionService.openLocationSettings();
}
