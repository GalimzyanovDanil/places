// ignore_for_file: public_member_api_docs, sort_constructors_first
class Geoposition {
  final double latitude;
  final double longitude;
  const Geoposition({
    required this.latitude,
    required this.longitude,
  });

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
