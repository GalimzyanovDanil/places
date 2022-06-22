import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';

enum PlaceType {
  park(
    AppAssets.iconPark,
    PlacesListStrings.parkType,
    PlacesListStrings.parkTypeFilter,
  ),

  museum(
    AppAssets.iconMuseum,
    PlacesListStrings.museumType,
    PlacesListStrings.museumTypeFilter,
  ),
  hotel(
    AppAssets.iconHotel,
    PlacesListStrings.hotelType,
    PlacesListStrings.hotelTypeFilter,
  ),
  restaurant(
    AppAssets.iconRestourant,
    PlacesListStrings.restaurantType,
    PlacesListStrings.restaurantTypeFilter,
  ),
  cafe(
    AppAssets.iconCafe,
    PlacesListStrings.cafeType,
    PlacesListStrings.cafeTypeFilter,
  ),
  other(
    AppAssets.iconParticularPlace,
    PlacesListStrings.otherType,
    PlacesListStrings.otherTypeFilter,
  );

  final String iconPath;
  final String title;
  final String filterTitle;

  const PlaceType(this.iconPath, this.title, this.filterTitle);

  factory PlaceType.fromString(String placeTypeResponse) {
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

  @override
  String toString() => name;
}
