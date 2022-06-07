import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/common/app_exceptions/api_exception.dart';
import 'package:places/features/common/service/geoposition_bloc/geoposition_bloc.dart';
import 'package:places/features/common/strings/dialog_strings.dart';
import 'package:places/features/common/widgets/alert_dialog/alert_dialog_widget_factory.dart';
import 'package:places/features/common/widgets/ui_func.dart';
import 'package:places/features/navigation/domain/entity/app_coordinate.dart';
import 'package:places/features/navigation/service/coordinator.dart';
import 'package:places/features/place_details/common/entity/details_sto.dart';
import 'package:places/features/places_list/common/entity/filter_sto.dart';
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
      geopositionBloc: appScope.geopositionBloc);

  return PlacesListWidgetModel(
    model: model,
    coordinator: appScope.coordinator,
  );
}

// TODO: cover with documentation
/// Default widget model for PlacesListWidget
class PlacesListWidgetModel
    extends WidgetModel<PlacesListScreen, PlacesListModel>
    implements IPlacesListWidgetModel {
  PlacesListWidgetModel(
      {required PlacesListModel model, required Coordinator coordinator})
      : _coordinator = coordinator,
        super(model);

  final Coordinator _coordinator;

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
    final currentPlace = _pagingController.itemList?[index];

    if (currentPlace != null) {
      final args = DetailsScreenTransferObject(
        place: currentPlace,
      );
      
      _coordinator.navigate(
        context,
        AppCoordinate.detailsPlaceScreen,
        arguments: args,
      );
    }
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
        _coordinator.navigate(context, AppCoordinate.filterSettingsScreen);
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
      final arguments = widget.transferObject;
      if (arguments == null) {
        await _getAllPlacesList(offset);
      } else {
        await _getFilteredPlaces(arguments);
      }
    } on ApiException catch (error) {
      _pagingController.error = error;
    }
  }

  Future<void> _getFilteredPlaces(FilterScreenTransferObject arguments) async {
    // TODO(me): Удалить после проверки
    await Future<void>.delayed(const Duration(seconds: 1));
    await model
        .getFilteredPlacesList(
      lat: arguments.lat,
      lng: arguments.lng,
      radius: arguments.radius,
      placeTypes: arguments.placeTypes,
    )
        .then((content) {
      content.sort((a, b) {
        assert(a.distance != null && b.distance != null,
            'Incorrect data from server');
        return a.distance!.compareTo(b.distance!);
      });
      _pagingController.appendLastPage(content);
    });
  }

  Future<void> _getAllPlacesList(int offset) async {
    await model.getPlacesList(placeCount, offset).then(
      (content) async {
        // TODO(me): Удалить после проверки
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
      },
    );
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
    return model.geopositionState.map<bool>(
        initial: (_) => false,
        getStatusInProgress: (_) => false,
        getPositionInProgress: (_) => true,
        succsess: (_) => true,
        error: (state) {
          if (state.status == GeopositionStatus.deniedForever) {
            showSnackBar(
                text: DialogStrings.geoPermissinoSnackBarText,
                context: context);
            return false;
          }
          _showMyDialog(
            alertDialogWidget: alertDialogWidgetFactory(
              title: DialogStrings.errorTitle,
              onConfirm: () async {
                model.requsetAndIsCheckPermission();
              },
              bodyText: DialogStrings.requetBodyText,
              confirmTitle: DialogStrings.confirmText,
              declineTitle: DialogStrings.declineText,
            ),
          );
          return false;
        });
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
