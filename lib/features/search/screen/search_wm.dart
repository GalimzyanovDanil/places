import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/navigation/app_router.dart';
import 'package:places/features/search/screen/search_model.dart';
import 'package:places/features/search/screen/search_screen.dart';
import 'package:provider/provider.dart';

abstract class ISearchWidgetModel extends IWidgetModel {
  ThemeData get theme;
  String? get queryText;
  ListenableState<List<Place>?> get listPlaceState;
  ListenableState<List<String>> get searchQueriesState;
  TextEditingController get searchBarController;
  Future<void> onClearText();
  void onClearHistory();
  Future<void> onDeleteQuery(int index);
  void onTapPlace(int index);
  void onBackButton();
}

SearchWidgetModel defaultSearchWidgetModelFactory(BuildContext context) {
  final appScope = context.read<IAppScope>();
  final model = SearchModel(
    queryDbService: appScope.searchDbService,
    placesService: appScope.placesService,
  );
  return SearchWidgetModel(
    model: model,
    router: appScope.router,
  );
}

// TODO(me): cover with documentation
/// Default widget model for SearchWidget
class SearchWidgetModel extends WidgetModel<SearchScreen, SearchModel>
    implements ISearchWidgetModel {
  final _searchQueriesState = StateNotifier<List<String>>();
  final _listPlaceState = StateNotifier<List<Place>?>();

  final AppRouter _router;

  late final TextEditingController _searchBarController;

  @override
  ThemeData get theme => Theme.of(context);

  @override
  String? get queryText => _queryText;

  @override
  ListenableState<List<Place>?> get listPlaceState => _listPlaceState;

  @override
  ListenableState<List<String>> get searchQueriesState => _searchQueriesState;

  @override
  TextEditingController get searchBarController => _searchBarController;

  //Таймер для задержки отправки запроса на сервер
  Timer? _searchDebounced;

  String? _queryText;

  SearchWidgetModel({
    required SearchModel model,
    required AppRouter router,
  })  : _router = router,
        super(model) {
    _init();
  }

  @override
  void onBackButton() {
    _router.pop(context);
  }

  @override
  Future<void> onClearHistory() async {
    await model.clearSearchQueries();
    await _acceptSearhQueriesState();
  }

  @override
  Future<void> onClearText() async {
    _searchBarController.clear();
  }

  @override
  Future<void> onDeleteQuery(int index) async {
    final queryText = _searchQueriesState.value![index];
    await model.deleteSearchQuery(queryText);
    await _acceptSearhQueriesState();
  }

  @override
  void onTapPlace(int index) {
    FocusScope.of(context).unfocus();
    final currentPlace = _listPlaceState.value![index];
    Future<void>.delayed(const Duration(milliseconds: 200))
        .whenComplete(() => _router.push(
              PlaceDetailsPageRoute(place: currentPlace),
            ));
  }

  Future<void> _init() async {
    _searchBarController = TextEditingController()
      ..addListener(() async {
        await _onChangeSearchField();
      });
    await _acceptSearhQueriesState();
  }

  Future<void> _onChangeSearchField() async {
    _searchDebounced?.cancel();
    _searchDebounced = Timer(
      const Duration(milliseconds: 700),
      () async {
        if (_searchBarController.value.text.isNotEmpty) {
          await _searchPlaces(_searchBarController.value.text);
        } else if (_listPlaceState.value != null) {
          _listPlaceState.accept(null);
          await _acceptSearhQueriesState();
        }
      },
    );
  }

  Future<void> _acceptSearhQueriesState() async {
    final prevQueries = await model.searchQueryEntries();
    _searchQueriesState.accept(prevQueries);
  }

  Future<void> _searchPlaces(String query) async {
    final places = await model.searchPlaceByName(query);
    _queryText = query;
    _listPlaceState.accept(places);
    if (places.isNotEmpty) unawaited(model.addSearchQuery(query));
  }
}
