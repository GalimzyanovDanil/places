import 'package:places/features/common/service/redux/app_state.dart';
import 'package:places/features/search/service/redux/action/search_actions.dart';
import 'package:redux/redux.dart';

class SearchScreenReducer {
  Reducer<AppState> obtainReducer() =>
      TypedReducer<AppState, SearchAction>(reducer);

  AppState reducer(
    AppState state,
    SearchAction action,
  ) {
    return action.map<AppState>(
      fetchRequestHistoryAction: (_) => state.copyWith(
        searchScreenState:
            state.searchScreenState.copyWith(isHistoryLoading: true),
      ),
      deleteRequestHistoryAction: (_) => state,
      clearRequestHistoryAction: (_) => state,
      fetchPlaceListAction: (_) => state.copyWith(
        searchScreenState:
            state.searchScreenState.copyWith(isPlacesLoading: true),
      ),
      addRequestHistoryAction: (_) => state,
      receivedHistoryAction: (action) => state.copyWith(
        searchScreenState: state.searchScreenState.copyWith(
          queryHistory: (action as ReceivedHistoryAction).queryHistory,
          isHistoryLoading: false,
        ),
      ),
      receivedPlacesAction: (action) => state.copyWith(
        searchScreenState: state.searchScreenState.copyWith(
          findedPlaces: (action as ReceivedPlacesAction).findedPlaces,
          isPlacesLoading: false,
        ),
      ),
    );
  }
}
