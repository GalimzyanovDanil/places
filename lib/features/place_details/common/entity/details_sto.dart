import 'package:places/features/common/screen_transfer_object.dart';
import 'package:places/features/places_list/domain/entity/place.dart';

class DetailsScreenTransferObject implements ScreenTransferObject {
  final Place place;

  DetailsScreenTransferObject({required this.place});
}
