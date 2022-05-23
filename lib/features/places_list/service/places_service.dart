import 'package:places/features/places_list/domain/entity/place.dart';
import 'package:places/features/places_list/domain/repository/places_repository.dart';

class PlacesService {
  final PlacesRepository _placesRepository;

  PlacesService(this._placesRepository);

  Future<List<Place>> getPlacesList(int count, [int offset = 0]) async {
    return _placesRepository.getPlacesList(count, offset);
  }
}
