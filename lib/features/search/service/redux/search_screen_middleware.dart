import 'package:places/features/common/domain/entity/place_filter.dart';
import 'package:places/features/common/domain/repository/places_repository.dart';
import 'package:places/features/common/service/redux/app_state.dart';
import 'package:places/features/search/repository/search_query_db_repository.dart';
import 'package:places/features/search/service/redux/action/search_actions.dart';
import 'package:redux/redux.dart';

class SearchScreenMiddleware {
  final SearchQueryDbRepository _queryDbRepository;
  final PlacesRepository _placesRepository;

  SearchScreenMiddleware({
    required SearchQueryDbRepository queryDbRepository,
    required PlacesRepository placesRepository,
  })  : _placesRepository = placesRepository,
        _queryDbRepository = queryDbRepository;

  Middleware<AppState> obtainMiddleware() =>
      TypedMiddleware<AppState, SearchAction>(_searchMiddleware);

  void _searchMiddleware(
    Store<AppState> store,
    SearchAction action,
    NextDispatcher next,
  ) {
    action.map<void>(
      fetchRequestHistoryAction: (action) =>
          _onFetchRequestHistoryAction(action, store),
      deleteRequestHistoryAction: (action) =>
          _onDeleteRequestHistoryAction(action, store),
      clearRequestHistoryAction: (action) =>
          _onClearRequestHistoryAction(action, store),
      fetchPlaceListAction: (action) => _onFetchPlaceListAction(action, store),
      receivedHistoryAction: (_) {},
      receivedPlacesAction: (_) {},
    );

    next(action);
  }

  Future<void> _onFetchRequestHistoryAction(
    SearchAction action,
    Store<AppState> store,
  ) async {
    await _dispatchQueryHistory(store);
  }

  Future<void> _onDeleteRequestHistoryAction(
    SearchAction action,
    Store<AppState> store,
  ) async {
    assert(
        action is DeleteRequestHistoryAction, 'Missmatch search action type');
    await _queryDbRepository
        .deleteSearchQuery((action as DeleteRequestHistoryAction).textRequest);
    await _dispatchQueryHistory(store);
  }

  Future<void> _onClearRequestHistoryAction(
    SearchAction action,
    Store<AppState> store,
  ) async {
    assert(action is ClearRequestHistoryAction, 'Missmatch search action type');
    await _queryDbRepository.clearSearchQueries();
    await _dispatchQueryHistory(store);
  }

  Future<void> _onFetchPlaceListAction(
    SearchAction action,
    Store<AppState> store,
  ) async {
    assert(action is FetchPlaceListAction, 'Missmatch search action type');

    final filter =
        PlaceFilter(nameFilter: (action as FetchPlaceListAction).query);
    final findedPlaces = await _placesRepository.getFilteredPlacesList(filter);

    store.dispatch(ReceivedPlacesAction(findedPlaces));
    if (findedPlaces.isNotEmpty) {
      await _queryDbRepository.addSearchQuery(action.query);
    }
  }

  Future<void> _dispatchQueryHistory(Store<AppState> store) async {
    final queryHistory = await _queryDbRepository.searchQueryEntries();
    store.dispatch(ReceivedHistoryAction(queryHistory));
  }
}
