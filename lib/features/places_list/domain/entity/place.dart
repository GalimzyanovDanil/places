import 'package:places/features/places_list/domain/entity/place_type.dart';

class Place {
  final int id;
  final double lat;
  final double lng;
  final String name;
  final List<String> urls;
  final PlaceType placeType;
  final String description;
  final double? distance;
  Place({
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
    this.distance,
  });
}
