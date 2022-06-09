import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/domain/repository/favorite_db_repository.dart';

class FavoriteDbService {
  final FavoriteDbRepository _favoriteDbRepository;

  FavoriteDbService(this._favoriteDbRepository);

  /// Получить список всех избранных мест
  Future<List<Place>> allFavoriteEntries() =>
      _favoriteDbRepository.allFavoriteEntries();

  /// Добавление/обновление избанного
  Future<void> addFavorite(Place place) =>
      _favoriteDbRepository.addFavorite(place);

  /// Удаление из избранных
  Future<void> deleteFavorite(int id) =>
      _favoriteDbRepository.deleteFavorite(id);
}
