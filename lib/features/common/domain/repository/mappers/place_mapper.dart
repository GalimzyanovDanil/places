import 'package:places/api/data/place_filter_request.dart';
import 'package:places/api/data/place_response.dart';
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
    typeFilter: filter.typeFilter.map((type) => type.name).toList(),
    nameFilter: filter.nameFilter,
  );
}
