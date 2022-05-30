import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:places/features/common/service/local_storage_service.dart';
import 'package:places/features/places_list/domain/entity/place_type.dart';

// TODO: cover with documentation
/// Default Elementary model for FilterSettings module
class FilterSettingsModel extends ElementaryModel {
  FilterSettingsModel(this._localStorageService) : super();

  final LocalStorageService _localStorageService;

  Future<List<PlaceType>?> getFilterPlaceTypes() async {
    return (await _localStorageService.getFilterPlaceTypes())
        ?.map<PlaceType>(PlaceType.fromString)
        .toList();
  }

  Future<double?> getFilterDistance() async {
    return _localStorageService.getFilterDistance();
  }

  Future<void> setFilterSettings(
      {required List<PlaceType> types, required double distance}) async {
    unawaited(_localStorageService
        .setFilterPlaceTypes(types.map((type) => type.name).toList()));
    unawaited(_localStorageService.setFilterDistance(distance));
  }
}
