import 'package:places/features/common/domain/entity/place_type.dart';

class PlaceFilter {
  final double? lat;
  final double? lng;
  final double? radius;
  final List<PlaceType>? typeFilter;
  final String? nameFilter;
  PlaceFilter({
    required this.lat,
    required this.lng,
    required double radius,
    required this.typeFilter,
    required this.nameFilter,
  }) : radius = radius * 1000;
}
