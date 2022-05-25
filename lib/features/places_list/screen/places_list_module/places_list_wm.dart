import 'dart:async';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/common/app_exceptions/api_exception.dart';
import 'package:places/features/navigation/domain/entity/app_coordinate.dart';
import 'package:places/features/navigation/service/coordinator.dart';
import 'package:places/features/places_list/domain/entity/place.dart';
import 'package:places/features/places_list/screen/places_list_module/places_list_model.dart';
import 'package:places/features/places_list/screen/places_list_module/places_list_screen.dart';
import 'package:provider/provider.dart';

abstract class IPlacesListWidgetModel extends IWidgetModel {
  PagingController<int, Place> get pagingController;
  void onTapCard(int index);
  Future<void> onRefresh();
  void onSearchBarTap();
  void onSettingsTap();
}

PlacesListWidgetModel defaultPlacesListWidgetModelFactory(
  BuildContext context,
) {
  final appDependencies = context.read<IAppScope>();
  final placesService = appDependencies.placesService;
  final model = PlacesListModel(
    errorHandler: appDependencies.errorHandler,
    placesService: placesService,
    connectivityResult: appDependencies.connectivityResult,
  );
  return PlacesListWidgetModel(
      model: model, coordinator: appDependencies.coordinator);
}

// TODO: cover with documentation
/// Default widget model for PlacesListWidget
class PlacesListWidgetModel
    extends WidgetModel<PlacesListScreen, PlacesListModel>
    implements IPlacesListWidgetModel {
  PlacesListWidgetModel(
      {required PlacesListModel model, required this.coordinator})
      : super(model);

  final Coordinator coordinator;

  /// Отступ от начального элемента базы
  final int currentOffset = 0;

  /// Количество загружаемых мест
  final placeCount = 15;

  /// Триггер последней страницы загрузки
  bool _isLastPage = false;

  late final PagingController<int, Place> _pagingController;

  @override
  PagingController<int, Place> get pagingController => _pagingController;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  void onTapCard(int index) {
    // TODO: implement onTapCard
  }

  @override
  Future<void> onRefresh() async {
    pagingController.refresh();
  }

  @override
  void onSearchBarTap() {
    // TODO: implement onSearchBarTap
  }

  @override
  void onSettingsTap() {
    coordinator.navigate(context, AppCoordinate.filterSettingsScreen);
  }

  // Инициализация
  Future<void> _init() async {
    _pagingController =
        PagingController<int, Place>(firstPageKey: currentOffset)
          ..addPageRequestListener(_getPlacesList);
  }

  // Получение списка мест
  Future<void> _getPlacesList(int offset) async {
    try {
      final content = await model.getPlacesList(placeCount, offset);
      await Future<void>.delayed(const Duration(seconds: 2));
      for (final element in content) {
        _correctImageUrls(element.urls);
      }
      _isLastPage = content.length < placeCount;
      if (_isLastPage) {
        _pagingController.appendLastPage(content);
      } else {
        final nextPageKey = offset + placeCount;
        _pagingController.appendPage(content, nextPageKey);
      }
    } on ApiException catch (error) {
      _pagingController.error = error;
    }
  }

  // Удаление URL, не являющихся ссылками на изображения
  void _correctImageUrls(List<String> list) {
    const checkList = ['.jpg', '.jpeg', '.png', '.svg'];

    list.retainWhere((element) {
      var isOk = false;
      for (var i = 0; i < checkList.length; i++) {
        isOk = element.endsWith(checkList[i]);
        if (isOk) break;
      }
      return isOk;
    });
  }
}
