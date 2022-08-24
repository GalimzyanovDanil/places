import 'package:places/features/search/service/redux/search_screen_state.dart';

class AppState {
  final SearchScreenState searchScreenState;
  const AppState({
    this.searchScreenState = const SearchScreenState(),
  });

  AppState copyWith({
    SearchScreenState? searchScreenState,
  }) {
    return AppState(
      searchScreenState: searchScreenState ?? this.searchScreenState,
    );
  }
}
