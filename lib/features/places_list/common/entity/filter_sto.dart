import 'package:places/features/common/entity/screen_transfer_object.dart';
import 'package:places/features/places_list/domain/entity/place_type.dart';

class FilterScreenTransferObject implements ScreenTransferObject {
  final List<PlaceType> placeTypes;
  final double radius;
  final double lat;
  final double lng;

  FilterScreenTransferObject({
    required this.lat,
    required this.lng,
    required this.placeTypes,
    required this.radius,
  });
}
