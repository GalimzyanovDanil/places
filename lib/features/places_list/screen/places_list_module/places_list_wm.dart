import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/common/app_exceptions/api_exception.dart';
import 'package:places/features/common/service/geoposition_service.dart';
import 'package:places/features/common/strings/alert_dialog_strings.dart';
import 'package:places/features/common/widgets/alert_dialog/alert_dialog_widget_factory.dart';
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
  Future<void> onSettingsTap();
}

PlacesListWidgetModel defaultPlacesListWidgetModelFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();

  final model = PlacesListModel(
      errorHandler: appScope.errorHandler,
      placesService: appScope.placesService,
      connectivityResult: appScope.connectivityResult,
      geopositionService: appScope.geopositionService);
  return PlacesListWidgetModel(model: model, coordinator: appScope.coordinator);
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
    _pagingController.dispose();
    super.dispose();
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
  Future<void> onSettingsTap() async {
    await _geopositionChecks().then((isEnabled) {
      if (isEnabled) {
        coordinator.navigate(context, AppCoordinate.filterSettingsScreen);
      }
    });
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
      await model.getPlacesList(placeCount, offset).then((content) async {
        // TODO: Удалить после проверки
        await Future<void>.delayed(const Duration(seconds: 1));
        for (final element in content) {
          _correctImageUrls(element.urls);
        }
        _isLastPage = content.length < placeCount;

        if (isMounted) {
          if (_isLastPage) {
            _pagingController.appendLastPage(content);
          } else {
            final nextPageKey = offset + placeCount;
            _pagingController.appendPage(content, nextPageKey);
          }
        }
      });
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

  Future<bool> _geopositionChecks() async {
    var status = GeopositionStatus.ok;
    status = await model.isCheckPermission();

    if (status == GeopositionStatus.denied) {
      await _showMyDialog(
          alertDialogWidget: alertDialogWidgetFactory(
              title: AlertDialogStrings.errorTitle,
              onConfirm: () async {
                status = await model.requsetAndIsCheckPermission();
              },
              bodyText: AlertDialogStrings.requetBodyText,
              confirmTitle: AlertDialogStrings.confirmText,
              declineTitle: AlertDialogStrings.declineText));
    }

    switch (status) {
      case GeopositionStatus.denied:
        return false;
      case GeopositionStatus.ok:
        return _isLocationServiceEnabled();
      case GeopositionStatus.deniedForever:
        // TODO(me): Можно показать снекбар
        // и попросить пользователся включить в настройках
        return false;
    }
  }

  Future<bool> _isLocationServiceEnabled() async {
    var isEnabled = false;
    isEnabled = await model.isLocationServiceEnabled();
    if (!isEnabled) {
      await _showMyDialog(
          alertDialogWidget: alertDialogWidgetFactory(
        title: AlertDialogStrings.title,
        bodyText: AlertDialogStrings.geoServiceNotEnabledText,
        confirmTitle: AlertDialogStrings.confirmText,
        declineTitle: AlertDialogStrings.declineText,
        onConfirm: model.openSettings,
      ));
      //Возвращаем TRUE, считая, что пользователь включил геолокацию(GPS)
      //Даже, если не включил она не жизненно необходима.
      isEnabled = true;
    }
    return isEnabled;
  }

  Future<void> _showMyDialog({required Widget alertDialogWidget}) async {
    if (isMounted) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return alertDialogWidget;
        },
      );
    }
  }
}
