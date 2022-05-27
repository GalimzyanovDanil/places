import 'package:places/api/data/place_response.dart';
import 'package:places/features/places_list/domain/entity/place.dart';
import 'package:places/features/places_list/domain/entity/place_type.dart';

/// Map [String] to [PlaceType]
PlaceType mapStringToPlaceType(String placeTypeResponse) {
  if (placeTypeResponse.toLowerCase() == PlaceType.park.name) {
    return PlaceType.park;
  }
  if (placeTypeResponse.toLowerCase() == PlaceType.museum.name) {
    return PlaceType.museum;
  }
  if (placeTypeResponse.toLowerCase() == PlaceType.hotel.name) {
    return PlaceType.hotel;
  }
  if (placeTypeResponse.toLowerCase() == PlaceType.restaurant.name) {
    return PlaceType.restaurant;
  }
  if (placeTypeResponse.toLowerCase() == PlaceType.cafe.name) {
    return PlaceType.cafe;
  }

  return PlaceType.other;
}

/// Map [PlaceResponse] to [Place]
Place mapResponseToPlace(PlaceResponse response) {
  return Place(
      id: response.id,
      lat: response.lat,
      lng: response.lng,
      name: response.name,
      urls: response.urls,
      placeType: mapStringToPlaceType(response.placeType),
      description: response.description,
      distance: response.distance);
}
