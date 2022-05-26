import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';

enum PlaceType {
  temple(
    AppAssets.iconParticularPlace,
    PlacesListStrings.otherType,
    PlacesListStrings.otherTypeFilter,
  ),
  monument(
    AppAssets.iconParticularPlace,
    PlacesListStrings.otherType,
    PlacesListStrings.otherTypeFilter,
  ),
  park(
    AppAssets.iconPark,
    PlacesListStrings.parkType,
    PlacesListStrings.parkTypeFilter,
  ),
  theatre(
    AppAssets.iconParticularPlace,
    PlacesListStrings.otherType,
    PlacesListStrings.otherTypeFilter,
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

  @override
  String toString() => name;
}
