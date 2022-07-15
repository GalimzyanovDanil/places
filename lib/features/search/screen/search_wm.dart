import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/service/redux/app_state.dart';
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
  void onClearText();
  void onClearHistory();
  void onDeleteQuery(int index);
  void onTapPlace(int index);
  void onBackButton();
}

SearchWidgetModel defaultSearchWidgetModelFactory(BuildContext context) {
  final appScope = context.read<IAppScope>();
  final model = SearchModel(
    storeDispatcher: appScope.storeDispatcher,
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
  late final StreamSubscription<AppState> _streamSubscription;

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
        super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _searchBarController = TextEditingController()
      ..addListener(_onChangeSearchField);

    _streamSubscription = model.appStream.listen((event) {
      if (_searchBarController.text.isNotEmpty &&
          !event.searchScreenState.isPlacesLoading) {
        _queryText = _searchBarController.text;
        _listPlaceState.accept(event.searchScreenState.findedPlaces);
      } else {
        _searchQueriesState.accept(event.searchScreenState.queryHistory);
      }
    });
    model.searchQueryEntries();
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  @override
  void onBackButton() {
    _router.pop(context);
  }

  @override
  void onClearHistory() {
    model.clearSearchQueries();
  }

  @override
  void onClearText() {
    _searchBarController.clear();
  }

  @override
  void onDeleteQuery(int index) {
    final queryText = _searchQueriesState.value![index];
    model.deleteSearchQuery(queryText);
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

  void _onChangeSearchField() {
    _searchDebounced?.cancel();
    _searchDebounced = Timer(
      const Duration(milliseconds: 700),
      () {
        if (_searchBarController.text.isNotEmpty) {
          model.searchPlaceByName(_searchBarController.text);
        } else if (_listPlaceState.value != null) {
          _listPlaceState.accept(null);
          model.searchQueryEntries();
        }
      },
    );
  }
}
