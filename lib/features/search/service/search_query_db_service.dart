import 'package:places/features/search/repository/search_query_db_repository.dart';

class SearchQueryDbService {
  final SearchQueryDbRepository _queryDbRepository;

  SearchQueryDbService(this._queryDbRepository);

  /// Получение списка всех удачных поисковых запросов на запрос
  Future<List<String>> searchQueryEntries(String queryText, {int? limit}) =>
      _queryDbRepository.searchQueryEntries(queryText, limit: limit);

  ///Удаление конкретной позиции
  Future<void> deleteSearchQuery(String queryText) =>
      _queryDbRepository.deleteSearchQuery(queryText);

  /// Очистка всей базы запросов
  Future<void> clearSearchQueries() => _queryDbRepository.clearSearchQueries();

  /// Добавление удачной поисковой строки
  Future<void> addSearchQuery(String queryText) =>
      _queryDbRepository.addSearchQuery(queryText);
}
