import 'package:elementary/elementary.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/domain/entity/place_filter.dart';
import 'package:places/features/common/service/places_service.dart';
import 'package:places/features/search/service/search_query_db_service.dart';

// TODO(me): cover with documentation
/// Default Elementary model for Search module
class SearchModel extends ElementaryModel {
  final SearchQueryDbService _queryDbService;
  final PlacesService _placesService;

  SearchModel({
    required SearchQueryDbService queryDbService,
    required PlacesService placesService,
  })  : _queryDbService = queryDbService,
        _placesService = placesService;

  /// Получение списка всех удачных поисковых запросов на запрос
  Future<List<String>> searchQueryEntries({int? limit}) =>
      _queryDbService.searchQueryEntries(limit: limit);

  ///Удаление конкретной позиции
  Future<void> deleteSearchQuery(String queryText) =>
      _queryDbService.deleteSearchQuery(queryText);

  /// Очистка всей базы запросов
  Future<void> clearSearchQueries() => _queryDbService.clearSearchQueries();

  /// Добавление удачной поисковой строки
  Future<void> addSearchQuery(String queryText) =>
      _queryDbService.addSearchQuery(queryText);

  /// Поиск мест по имени
  Future<List<Place>> searchPlaceByName(String name) =>
      _placesService.getFilteredPlace(PlaceFilter(nameFilter: name));
}
