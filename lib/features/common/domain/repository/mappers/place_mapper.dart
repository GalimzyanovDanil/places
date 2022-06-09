import 'package:places/api/data/place_filter_request.dart';
import 'package:places/api/data/place_response.dart';
import 'package:places/database/places_database.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/domain/entity/place_filter.dart';
import 'package:places/features/common/domain/entity/place_type.dart';

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
    distance: response.distance,
  );
}

PlaceFilterRequest mapPlaceFilterToRequest(PlaceFilter filter) {
  return PlaceFilterRequest(
    lat: filter.lat,
    lng: filter.lng,
    radius: filter.radius,
    typeFilter: filter.typeFilter?.map((type) => type.name).toList(),
    nameFilter: filter.nameFilter,
  );
}

Favorite mapPlaceToFavorite(Place place) {
  return Favorite(
    id: place.id,
    lat: place.lat,
    lng: place.lng,
    name: place.name,
    urls: place.urls.join('|'),
    placeType: place.placeType.name,
    description: place.description,
    distance: place.distance,
    isVisited: place.isVisited ?? false,
    plannedDate: place.plannedDate,
  );
}

Place mapFavoriteToPlace(Favorite favorite) {
  return Place(
    id: favorite.id,
    lat: favorite.lat,
    lng: favorite.lng,
    name: favorite.name,
    urls: favorite.urls.split('|'),
    placeType: PlaceType.fromString(favorite.placeType),
    description: favorite.description,
    distance: favorite.distance,
    isVisited: favorite.isVisited,
    plannedDate: favorite.plannedDate,
  );
}
