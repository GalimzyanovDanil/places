import 'package:json_annotation/json_annotation.dart';

part 'place_add_request.g.dart';

@JsonSerializable()
class PlaceAddRequest {
  final double lat;
  final double lng;
  final String name;
  final List<String> urls;
  final String placeType;
  final String description;

  const PlaceAddRequest({
    required this.lat,
    required this.lng,
    required this.name,
    required this.urls,
    required this.placeType,
    required this.description,
  });

  factory PlaceAddRequest.fromJson(Map<String, dynamic> json) =>
      _$PlaceAddRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceAddRequestToJson(this);
}
