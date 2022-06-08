import 'package:places/api/service/place_api.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/domain/entity/place_filter.dart';
import 'package:places/features/common/domain/repository/mappers/place_mapper.dart';

class PlacesRepository {
  final PlaceApi _apiClient;

  PlacesRepository(this._apiClient);

  /// Запросить [count] количество мест с отступом [offset] от первого элемента в базе
  Future<List<Place>> getPlacesList(int count, [int offset = 0]) async {
    final queries = <String, dynamic>{
      'count': '$count',
      'offset': '$offset',
    };
    return _apiClient
        .getPlaces(queries)
        .then((value) => value.map<Place>(mapResponseToPlace).toList());
  }

  Future<List<Place>> getFilteredPlacesList(PlaceFilter filter) async {
    return _apiClient
        .getFilteredPlace(mapPlaceFilterToRequest(filter))
        .then((value) => value.map<Place>(mapResponseToPlace).toList());
  }
}
