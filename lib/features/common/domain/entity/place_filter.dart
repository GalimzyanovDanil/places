import 'package:places/features/common/domain/entity/place_type.dart';

class PlaceFilter {
  final double? lat;
  final double? lng;
  final double? radius;
  final List<PlaceType>? typeFilter;
  final String? nameFilter;
  PlaceFilter({
    this.lat,
    this.lng,
    double? radius,
    this.typeFilter,
    this.nameFilter,
  }) : radius = radius == null ? null : radius * 1000;
}
