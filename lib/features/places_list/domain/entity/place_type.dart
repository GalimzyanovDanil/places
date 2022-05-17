import 'package:places/features/places_list/strings/place_type_strings.dart';

enum PlaceType {
  temple,
  monument,
  park,
  theatre,
  museum,
  hotel,
  restaurant,
  cafe,
  other;

  @override
  String toString() => name;

  static PlaceType fromString(String placeTypeResponse) {
    if (placeTypeResponse == PlaceType.park.toString()) {
      return PlaceType.park;
    }
    if (placeTypeResponse == PlaceType.museum.toString()) {
      return PlaceType.museum;
    }
    if (placeTypeResponse == PlaceType.hotel.toString()) {
      return PlaceType.hotel;
    }
    if (placeTypeResponse == PlaceType.restaurant.toString()) {
      return PlaceType.restaurant;
    }
    if (placeTypeResponse == PlaceType.cafe.toString()) {
      return PlaceType.cafe;
    }

    return PlaceType.other;
  }

  String toTitle() {
    switch (this) {
      case PlaceType.park:
        return PlaceTypeStrings.park;
      case PlaceType.museum:
        return PlaceTypeStrings.museum;
      case PlaceType.hotel:
        return PlaceTypeStrings.hotel;
      case PlaceType.restaurant:
        return PlaceTypeStrings.restaurant;
      case PlaceType.cafe:
        return PlaceTypeStrings.cafe;
      case PlaceType.other:
      case PlaceType.temple:
      case PlaceType.monument:
      case PlaceType.theatre:
        return PlaceTypeStrings.other;
    }
  }
}
