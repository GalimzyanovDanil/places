import 'package:elementary/elementary.dart';
import 'package:places/features/places_list/domain/entity/place.dart';
import 'package:places/features/places_list/service/places_service.dart';

// TODO: cover with documentation
/// Default Elementary model for PlacesList module
class PlacesListModel extends ElementaryModel {
  final PlacesService _placesService;
  final ErrorHandler _errorHandler;
  PlacesListModel(
      {required ErrorHandler errorHandler,
      required PlacesService placesService})
      : _placesService = placesService,
        _errorHandler = errorHandler,
        super(errorHandler: errorHandler);

  Future<List<Place>> getPlacesList(int count, [int offset = 0]) async {
    try {
      final List<Place> result;
      result = await _placesService.getPlacesList(count, offset);
      return result;
    } on Object catch (error) {
      _errorHandler.handleError(error);
      rethrow;
    }
  }
}
