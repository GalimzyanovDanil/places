import 'package:places/features/places_list/strings/places_list_strings.dart';

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
        return PlacesListStrings.parkType;
      case PlaceType.museum:
        return PlacesListStrings.museumType;
      case PlaceType.hotel:
        return PlacesListStrings.hotelType;
      case PlaceType.restaurant:
        return PlacesListStrings.restaurantType;
      case PlaceType.cafe:
        return PlacesListStrings.cafeType;
      case PlaceType.other:
      case PlaceType.temple:
      case PlaceType.monument:
      case PlaceType.theatre:
        return PlacesListStrings.otherType;
    }
  }
}
