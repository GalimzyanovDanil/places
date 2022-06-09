// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final bool? isVisited;
  final DateTime? plannedDate;

  Place({
    required this.id,
    required this.lat,
    required this.lng,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
    this.distance,
    this.isVisited,
    this.plannedDate,
  });

  @override
  String toString() {
    return 'Place(id: $id, name: $name, placeType: $placeType)';
  }

  Place copyWith({
    int? id,
    double? lat,
    double? lng,
    String? name,
    List<String>? urls,
    PlaceType? placeType,
    String? description,
    double? distance,
    bool? isVisited,
    DateTime? plannedDate,
  }) {
    return Place(
      id: id ?? this.id,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      name: name ?? this.name,
      urls: urls ?? this.urls,
      placeType: placeType ?? this.placeType,
      description: description ?? this.description,
      distance: distance ?? this.distance,
      isVisited: isVisited ?? this.isVisited,
      plannedDate: plannedDate ?? this.plannedDate,
    );
  }
}
