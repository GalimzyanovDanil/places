import 'package:places/database/places_database.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/domain/repository/mappers/place_mapper.dart';

class FavoriteDbRepository {
  final PlacesDatabase database;
  FavoriteDbRepository(this.database);

  /// Получить список всех избранных мест
  Future<List<Place>> allFavoriteEntries() async {
    return (await database.allFavoriteEntries())
        .map(mapFavoriteToPlace)
        .toList();
  }

  /// Добавление/обновление избанного
  Future<void> addFavorite(Place place) =>
      database.addFavorite(mapPlaceToFavorite(place));

  /// Удаление из избранных
  Future<void> deleteFavorite(int id) => database.deleteFavorite(id);
}
