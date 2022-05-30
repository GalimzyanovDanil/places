import 'package:places/api/data/place_response.dart';
import 'package:places/features/places_list/domain/entity/place.dart';
import 'package:places/features/places_list/domain/entity/place_type.dart';

/// Map [PlaceResponse] to [Place]
Place mapResponseToPlace(PlaceResponse response) {
  return Place(
      id: response.id,
      lat: response.lat,
      lng: response.lng,
      name: response.name,
      urls: response.urls,
      placeType: PlaceType.fromString(response.placeType),
      description: response.description,
      distance: response.distance);
}
