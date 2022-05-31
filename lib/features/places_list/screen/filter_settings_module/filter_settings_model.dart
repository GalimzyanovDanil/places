import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:places/features/common/service/app_settings_service.dart';
import 'package:places/features/places_list/domain/entity/place_type.dart';

// TODO: cover with documentation
/// Default Elementary model for FilterSettings module
class FilterSettingsModel extends ElementaryModel {
  FilterSettingsModel(this._appSettingsService) : super();

  final AppSettingsService _appSettingsService;

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
}
