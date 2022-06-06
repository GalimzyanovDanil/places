import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:elementary/elementary.dart';
import 'package:places/features/common/app_exceptions/api_exception_handler.dart';
import 'package:places/features/common/service/app_settings_service.dart';
import 'package:places/features/common/service/geoposition_bloc/geoposition_bloc.dart';
import 'package:places/features/places_list/domain/entity/place.dart';
import 'package:places/features/places_list/domain/entity/place_filter.dart';
import 'package:places/features/places_list/domain/entity/place_type.dart';
import 'package:places/features/places_list/service/places_service.dart';

// TODO: cover with documentation
/// Default Elementary model for FilterSettings module
class FilterSettingsModel extends ElementaryModel {
  FilterSettingsModel({
    required ErrorHandler errorHandler,
    required AppSettingsService appSettingsService,
    required PlacesService placesService,
    required ConnectivityResult connectivityResult,
    required GeopositionBloc geopositionBloc,
  })  : _appSettingsService = appSettingsService,
        _errorHandler = errorHandler,
        _connectivityResult = connectivityResult,
        _placesService = placesService,
        _geopositionBloc = geopositionBloc,
        super();

  final AppSettingsService _appSettingsService;
  final PlacesService _placesService;
  final ErrorHandler _errorHandler;
  final ConnectivityResult _connectivityResult;
  final GeopositionBloc _geopositionBloc;

  GeopositionState get geopositionState => _geopositionBloc.state;

  Future<List<PlaceType>?> getFilterPlaceTypes() async {
    return _appSettingsService.getFilterPlaceTypes().then(
          (value) => value.map<PlaceType>(PlaceType.fromString).toList(),
        );
  }

  Future<double?> getFilterDistance() async {
    return _appSettingsService.getFilterDistance();
  }

  Future<void> setFilterSettings(
      {required List<PlaceType> types, required double distance}) async {
    unawaited(_appSettingsService
        .setFilterPlaceTypes(types.map((type) => type.name).toList()));
    unawaited(_appSettingsService.setFilterDistance(distance));
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

  void getCurrentGeoposition() {
    _geopositionBloc.add(const GeopositionEvent.getGeoposition());
  }
}
