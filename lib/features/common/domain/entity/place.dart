import 'package:places/features/common/domain/entity/place_type.dart';

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

  @override
  String toString() {
    return 'Place(id: $id, name: $name, placeType: $placeType)';
  }
}
