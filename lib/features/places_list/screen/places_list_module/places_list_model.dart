import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:elementary/elementary.dart';
import 'package:places/features/common/app_exceptions/api_exception_handler.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/domain/entity/place_filter.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/common/service/app_settings_service.dart';
import 'package:places/features/common/service/geoposition_bloc/geoposition_bloc.dart';
import 'package:places/features/common/service/places_service.dart';

// TODO(me): cover with documentation
/// Default Elementary model for PlacesList module
class PlacesListModel extends ElementaryModel {
  final PlacesService _placesService;
  final ErrorHandler _errorHandler;
  final ConnectivityResult _connectivityResult;
  final GeopositionBloc _geopositionBloc;
  final AppSettingsService _appSettingsService;

  GeopositionState get geopositionState => _geopositionBloc.state;

  PlacesListModel({
    required ErrorHandler errorHandler,
    required PlacesService placesService,
    required ConnectivityResult connectivityResult,
    required GeopositionBloc geopositionBloc,
    required AppSettingsService appSettingsService,
  })  : _placesService = placesService,
        _errorHandler = errorHandler,
        _connectivityResult = connectivityResult,
        _geopositionBloc = geopositionBloc,
        _appSettingsService = appSettingsService,
        super(errorHandler: errorHandler);

  Future<List<Place>> getPlacesList(int count, [int offset = 0]) async {
    try {
      final List<Place> result;
      result = await _placesService.getPlacesList(count, offset);
      return result;
    } on Object catch (error) {
      throw apiExceptionHandle(
        error: error,
        connectivityResult: _connectivityResult,
        errorHandler: _errorHandler,
      );
    }
  }

  Future<List<Place>> getFilteredPlacesList({
    required double lat,
    required double lng,
    required double radius,
    required List<PlaceType> placeTypes,
  }) async {
    try {
      final List<Place> result;
      final filter = PlaceFilter(
        lat: lat,
        lng: lng,
        radius: radius,
        typeFilter: placeTypes,
        nameFilter: '',
      );

      result = await _placesService.getFilteredPlace(filter);
      return result;
    } on Object catch (error) {
      throw apiExceptionHandle(
        error: error,
        connectivityResult: _connectivityResult,
        errorHandler: _errorHandler,
      );
    }
  }

  void requsetAndIsCheckPermission() {
    _geopositionBloc.add(const GeopositionEvent.checkAndRequestPermission());
  }

  Future<double> getFilterDistance() => _appSettingsService.getFilterDistance();
  Future<List<String>> getFilterPlaceType() =>
      _appSettingsService.getFilterPlaceTypes();
}
