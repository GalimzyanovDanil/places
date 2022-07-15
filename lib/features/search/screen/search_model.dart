import 'package:elementary/elementary.dart';

import 'package:places/features/common/service/redux/app_state.dart';
import 'package:places/features/common/service/redux/store.dart';
import 'package:places/features/search/service/redux/action/search_actions.dart';

// TODO(me): cover with documentation
/// Default Elementary model for Search module
class SearchModel extends ElementaryModel {
  final StoreDispatcher _storeDispatcher;

  Stream<AppState> get appStream => _storeDispatcher.stateStream;

  SearchModel({
    required StoreDispatcher storeDispatcher,
  }) : _storeDispatcher = storeDispatcher;

  /// Получение списка всех удачных поисковых запросов на запрос
  void searchQueryEntries() =>
      _storeDispatcher.dispatch(FetchRequestHistoryAction());

  ///Удаление конкретной позиции
  void deleteSearchQuery(String queryText) =>
      _storeDispatcher.dispatch(DeleteRequestHistoryAction(queryText));

  /// Очистка всей базы запросов
  void clearSearchQueries() =>
      _storeDispatcher.dispatch(ClearRequestHistoryAction());

  /// Поиск мест по имени
  void searchPlaceByName(String name) =>
      _storeDispatcher.dispatch(FetchPlaceListAction(name));
}
