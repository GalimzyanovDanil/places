// ignore_for_file: public_member_api_docs, sort_constructors_first
class Geoposition {
  final double latitude;
  final double longitude;
  const Geoposition({
    required this.latitude,
    required this.longitude,
  });

  const Geoposition.notReceived()
      : latitude = 0.0,
        longitude = 0.0;

  Geoposition copyWith({
    double? latitude,
    double? longitude,
  }) {
    return Geoposition(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
