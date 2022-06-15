import 'package:elementary/elementary.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/service/favorite_db_service.dart';

// TODO: cover with documentation
/// Default Elementary model for FavoriteButton module
class FavoriteButtonModel extends ElementaryModel {
  final FavoriteDbService _favoriteDbService;

  FavoriteButtonModel(this._favoriteDbService);

  /// Проверка является ли данное место избранным
  Future<Place?> checkPlaceIsFavorite(int id) =>
      _favoriteDbService.checkPlaceIsFavorite(id);

  /// Добавление/обновление избанного
  Future<void> addFavorite(Place place) =>
      _favoriteDbService.addFavorite(place);

  /// Удаление из избранных
  Future<void> deleteFavorite(int id) => _favoriteDbService.deleteFavorite(id);
}
