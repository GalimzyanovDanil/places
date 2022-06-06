import 'package:json_annotation/json_annotation.dart';

part 'place_filter_request.g.dart';

@JsonSerializable()
class PlaceFilterRequest {
  final double lat;
  final double lng;
  final double radius;
  final List<String> typeFilter;
  final String nameFilter;
  PlaceFilterRequest({
    required this.lat,
    required this.lng,
    required this.radius,
    required this.typeFilter,
    required this.nameFilter,
  });

  factory PlaceFilterRequest.fromJson(Map<String, dynamic> json) =>
      _$PlaceFilterRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceFilterRequestToJson(this);
}
