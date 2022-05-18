import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/places_list/domain/entity/place.dart';
import 'package:places/features/places_list/screen/places_list_model.dart';
import 'package:places/features/places_list/screen/places_list_screen.dart';
import 'package:provider/provider.dart';

abstract class IPlacesListWidgetModel extends IWidgetModel {
  ListenableState<EntityState<List<Place>>> get placesState;
  ScrollController get scrollController;
  Future<void> pagination(int index);
  Future<void> refresh();
  void addFavorite(int index);
}

PlacesListWidgetModel defaultPlacesListWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final placesService = appDependencies.placesService;
  final model = PlacesListModel(
      errorHandler: appDependencies.errorHandler, placesService: placesService);
  return PlacesListWidgetModel(model);
}

// TODO: cover with documentation
/// Default widget model for PlacesListWidget
class PlacesListWidgetModel
    extends WidgetModel<PlacesListScreen, PlacesListModel>
    implements IPlacesListWidgetModel {
  PlacesListWidgetModel(PlacesListModel model) : super(model);

  /// Отступ от начального элемента базы
  int currentOffset = 0;

  /// Количество загружаемых мест
  final placeCount = 15;

  /// Триггер последней страницы загрузки
  bool _isLastPage = false;

  /// Список мест
  final List<Place> _placesList = [];

  late final EntityStateNotifier<List<Place>> _placesState;
  late final ScrollController _scrollController;

  @override
  ListenableState<EntityState<List<Place>>> get placesState => _placesState;

  @override
  ScrollController get scrollController => _scrollController;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
    _loadPlaces(placeCount, true);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Future<void> pagination(int index) async {
    if ((index > (placeCount + currentOffset) - 3) && !_isLastPage) {
      currentOffset = currentOffset + placeCount;
      unawaited(_loadPlaces(currentOffset));
    }
  }

  @override
  void addFavorite(int index) {
    // TODO: implement addFavorite
  }

  @override
  Future<void> refresh() {
    // TODO: implement refresh
    throw UnimplementedError();
  }

  Future<void> _init() async {
    _placesState = EntityStateNotifier<List<Place>>();
    _scrollController = ScrollController();
  }

  Future<void> _loadPlaces([
    int offset = 0,
    bool isFirstLoading = false,
  ]) async {
    if (isFirstLoading) _placesState.loading();
    try {
      final content = await model.getPlacesList(placeCount, offset);
      _isLastPage = content.length < placeCount;
      _placesList.addAll(content);
      _placesState.content(_placesList);
    } on Object catch (_) {
      _placesState.error();
    }
  }
}
