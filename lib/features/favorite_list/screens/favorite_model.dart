import 'package:elementary/elementary.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/service/favorite_db_service.dart';

// TODO(me): cover with documentation
/// Default Elementary model for Favorite module
class FavoriteModel extends ElementaryModel {
  final FavoriteDbService _favoriteDbService;

  FavoriteModel(this._favoriteDbService);

  /// Получить список всех избранных мест
  Future<List<Place>> allFavoriteEntries() =>
      _favoriteDbService.allFavoriteEntries();

  /// Добавление/обновление избанного
  Future<void> addFavorite(Place place) =>
      _favoriteDbService.addFavorite(place);

  /// Удаление из избранных
  Future<void> deleteFavorite(int id) => _favoriteDbService.deleteFavorite(id);
}
