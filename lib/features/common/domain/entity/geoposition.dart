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
}
