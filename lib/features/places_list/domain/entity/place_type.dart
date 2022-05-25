import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';

enum PlaceType {
  temple(AppAssets.iconParticularPlace),
  monument(AppAssets.iconParticularPlace),
  park(AppAssets.iconPark),
  theatre(AppAssets.iconParticularPlace),
  museum(AppAssets.iconMuseum),
  hotel(AppAssets.iconHotel),
  restaurant(AppAssets.iconRestourant),
  cafe(AppAssets.iconCafe),
  other(AppAssets.iconParticularPlace);

  final String iconPath;

  const PlaceType(this.iconPath);

  @override
  String toString() => name;

  static PlaceType fromString(String placeTypeResponse) {
    if (placeTypeResponse.toLowerCase() == PlaceType.park.toString()) {
      return PlaceType.park;
    }
    if (placeTypeResponse.toLowerCase() == PlaceType.museum.toString()) {
      return PlaceType.museum;
    }
    if (placeTypeResponse.toLowerCase() == PlaceType.hotel.toString()) {
      return PlaceType.hotel;
    }
    if (placeTypeResponse.toLowerCase() == PlaceType.restaurant.toString()) {
      return PlaceType.restaurant;
    }
    if (placeTypeResponse.toLowerCase() == PlaceType.cafe.toString()) {
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

  String toFilterTitle() {
    switch (this) {
      case PlaceType.park:
        return PlacesListStrings.parkTypeFilter;
      case PlaceType.museum:
        return PlacesListStrings.museumTypeFilter;
      case PlaceType.hotel:
        return PlacesListStrings.hotelTypeFilter;
      case PlaceType.restaurant:
        return PlacesListStrings.restaurantTypeFilter;
      case PlaceType.cafe:
        return PlacesListStrings.cafeTypeFilter;
      case PlaceType.other:
      case PlaceType.temple:
      case PlaceType.monument:
      case PlaceType.theatre:
        return PlacesListStrings.otherTypeFilter;
    }
  }
}
