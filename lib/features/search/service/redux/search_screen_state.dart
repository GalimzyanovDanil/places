import 'package:places/features/common/domain/entity/place.dart';

class SearchScreenState {
  final List<Place> findedPlaces;
  final bool isPlacesLoading;
  final List<String> queryHistory;
  final bool isHistoryLoading;

  const SearchScreenState({
    this.findedPlaces = const [],
    this.queryHistory = const [],
    this.isPlacesLoading = false,
    this.isHistoryLoading = false,
  });

  SearchScreenState copyWith({
    List<Place>? findedPlaces,
    bool? isPlacesLoading,
    List<String>? queryHistory,
    bool? isHistoryLoading,
  }) {
    return SearchScreenState(
      findedPlaces: findedPlaces ?? this.findedPlaces,
      isPlacesLoading: isPlacesLoading ?? this.isPlacesLoading,
      queryHistory: queryHistory ?? this.queryHistory,
      isHistoryLoading: isHistoryLoading ?? this.isHistoryLoading,
    );
  }
}
