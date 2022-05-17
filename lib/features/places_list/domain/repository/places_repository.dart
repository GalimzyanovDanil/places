import 'package:places/api/service/place_api.dart';
import 'package:places/features/places_list/domain/entity/place.dart';
import 'package:places/features/places_list/domain/mappers/place_mapper.dart';

class PlacesRepository {
  final PlaceApi _apiClient;

  PlacesRepository(this._apiClient);

  Future<List<Place>> getPlacesList(int count, [int offset = 0]) async {
    try {
      return _apiClient
          .getPlaces(count, offset)
          .then((value) => value.map<Place>(placeFromResponse).toList());
    } on Object catch (_) {
      rethrow;
    }
  }
}
