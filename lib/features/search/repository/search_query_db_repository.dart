import 'package:places/database/places_database.dart';

class SearchQueryDbRepository {
  final PlacesDatabase _database;
  SearchQueryDbRepository(this._database);

  /// Получение списка всех удачных поисковых запросов на запрос
  Future<List<String>> searchQueryEntries(String queryText, {int? limit}) =>
      _database.searchQueryEntries(queryText, limit: limit);

  ///Удаление конкретной позиции
  Future<void> deleteSearchQuery(String queryText) =>
      _database.deleteSearchQuery(queryText);

  /// Очистка всей базы запросов
  Future<void> clearSearchQueries() => _database.clearSearchQueries();

  /// Добавление удачной поисковой строки
  Future<void> addSearchQuery(String queryText) =>
      _database.addSearchQuery(queryText);
}
