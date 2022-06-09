import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:places/database/tables/favorites.dart';
import 'package:places/database/tables/search_queries.dart';

part 'places_database.g.dart';

@DriftDatabase(tables: [Favorites, SearchQueries])
class PlacesDatabase extends _$PlacesDatabase {
  @override
  int get schemaVersion => 1;

  PlacesDatabase() : super(_openConnection());

  /// Получить список всех избранных мест
  Future<List<Favorite>> allFavoriteEntries() => select(favorites).get();

  /// Добавление/обновление избанного
  Future<void> addFavorite(Favorite favorite) =>
      favorites.insertOnConflictUpdate(favorite);

  /// Удаление из избранных
  Future<void> deleteFavorite(int id) =>
      favorites.deleteWhere((tbl) => tbl.id.equals(id));

  /// Получение списка всех удачных поисковых запросов
  Future<List<String>> searchQueryEntries({
    int? limit,
  }) async {
    final result = await ((select(searchQueries))..limit(limit ?? 5)).get();
    return result.map((searchQuery) => searchQuery.queryText).toList();
  }

  ///Удаление конкретной позиции
  Future<void> deleteSearchQuery(String queryText) =>
      searchQueries.deleteWhere((tbl) => tbl.queryText.equals(queryText));

  /// Очистка всей базы запросов
  Future<void> clearSearchQueries() async {
    delete(searchQueries);
  }

  /// Добавление удачной поисковой строки
  Future<void> addSearchQuery(String queryText) =>
      into(searchQueries).insertOnConflictUpdate(
        SearchQueriesCompanion(
          queryText: Value(queryText),
        ),
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
