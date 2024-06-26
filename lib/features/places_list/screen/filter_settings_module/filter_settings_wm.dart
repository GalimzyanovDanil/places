// ignore_for_file: avoid_positional_boolean_parameters

import 'dart:async';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/common/app_exceptions/api_exception.dart';
import 'package:places/features/common/domain/entity/geoposition.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/common/strings/dialog_strings.dart';
import 'package:places/features/common/widgets/ui_func.dart';
import 'package:places/features/navigation/app_router.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_model.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_screen.dart';
import 'package:provider/provider.dart';

abstract class IFilterSettingsWidgetModel extends IWidgetModel {
  ListenableState<EntityState<List<Place>>> get listPlaceState;
  ListenableState<double> get sliderState;
  ListenableState<List<PlaceType>> get filterState;
  ThemeData get theme;
  double get minSliderValue;
  double get maxSliderValue;
  void onBackButtonTap();
  void onClearTap();
  void onShowResultTap();
  void onSliderChange(double value);
  void onElementTap(bool isSel, PlaceType type);
}

FilterSettingsWidgetModel defaultFilterSettingsWidgetModelFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();

  final model = FilterSettingsModel(
    appSettingsService: appScope.appSettingsService,
    placesService: appScope.placesService,
    geopositionBloc: appScope.geopositionBloc,
    connectivityResult: appScope.connectivityResult,
    errorHandler: appScope.errorHandler,
  );
  return FilterSettingsWidgetModel(
    model: model,
    router: appScope.router,
    messageController: appScope.messageController,
  );
}

// TODO(me): cover with documentation
/// Default widget model for FilterSettingsWidget
class FilterSettingsWidgetModel
    extends WidgetModel<FilterSettingsScreen, FilterSettingsModel>
    implements IFilterSettingsWidgetModel {
  //Значение слайдера по умолчанию
  static const _defaultSliderValue = 10.0;

  // Список всех типов
  @visibleForTesting
  final allPlaceType = <PlaceType>[
    PlaceType.hotel,
    PlaceType.restaurant,
    PlaceType.other,
    PlaceType.park,
    PlaceType.museum,
    PlaceType.cafe,
  ];

  final AppRouter router;
  final MessageController messageController;

  final StateNotifier<List<PlaceType>> _filterState =
      StateNotifier<List<PlaceType>>(initValue: <PlaceType>[]);
  final StateNotifier<double> _sliderState =
      StateNotifier<double>(initValue: _defaultSliderValue);

  final _listPlaceState = EntityStateNotifier<List<Place>>();

  // Максимальное значение слайдера
  final _maxSliderValue = 30.0;
  // Минимальное значение слайдера
  final _minSliderValue = 10.0;

  @override
  ListenableState<List<PlaceType>> get filterState => _filterState;

  @override
  ListenableState<EntityState<List<Place>>> get listPlaceState =>
      _listPlaceState;

  @override
  ListenableState<double> get sliderState => _sliderState;

  @override
  double get maxSliderValue => _maxSliderValue;

  @override
  double get minSliderValue => _minSliderValue;

  @override
  ThemeData get theme => Theme.of(context);

  //Таймер для задержки отправки запроса на сервер
  Timer? _searchDebounced;

  Geoposition? _position;

  FilterSettingsWidgetModel({
    required FilterSettingsModel model,
    required this.router,
    required this.messageController,
  }) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    init();
  }

  @override
  void onBackButtonTap() {
    router.pop(false);
  }

  @override
  void onClearTap() {
    _filterState.accept(List<PlaceType>.from(<PlaceType>[]));
    _sliderState.accept(_defaultSliderValue);
    _loadPlaceListDebounce();
  }

  @override
  void onShowResultTap() {
    _saveSetttings().whenComplete(() => router.pop(true));
  }

  @override
  void onSliderChange(double value) {
    _sliderState.accept(value);
    _loadPlaceListDebounce();
  }

  // Обработка нажатия на элемент фильтра
  @override
  void onElementTap(bool isSel, PlaceType type) {
    final filterList = _filterState.value?.toList();

    if (isSel) {
      filterList?.remove(type);
      _filterState.accept(
        List<PlaceType>.from(filterList ?? <PlaceType>[]),
      );
    } else {
      filterList?.add(type);
      _filterState.accept(
        List<PlaceType>.from(filterList ?? <PlaceType>[]),
      );
    }
    _loadPlaceListDebounce();
  }

  @visibleForTesting
  Future<void> init() async {
    await _initFilterSettings();
    await _loadPlaceList();
  }

  Future<void> _initFilterSettings() async {
    final initialFilterTypes = await model.getFilterPlaceTypes();
    final initialFilterDistance = await model.getFilterDistance();
    _filterState.accept(initialFilterTypes);
    _sliderState.accept(initialFilterDistance);
  }

  // Загрузка данных по данным фильтра с задержкой
  Future<void> _loadPlaceListDebounce() async {
    _searchDebounced?.cancel();
    _searchDebounced = Timer(const Duration(seconds: 1), () async {
      await _loadPlaceList();
    });
  }

  Future<void> _loadPlaceList() async {
    _listPlaceState.loading();
    model.getCurrentGeoposition();

    _position ??= model.geopositionState.geoposition;
    assert(_position != null, 'Position can not be null!');

    try {
      final listPlaces = await model.getFilteredPlacesList(
        lat: _position!.latitude,
        lng: _position!.longitude,
        radius: _sliderState.value!,
        placeTypes: _filterState.value!,
      );

      _listPlaceState.content(listPlaces);
    } on ApiException catch (error) {
      switch (error.exceptionType) {
        case ApiExceptionType.network:
          unawaited(messageController.showSnackBar(
            text: DialogStrings.networkErrorSnackBarText,
            context: context,
          ));
          break;
        case ApiExceptionType.other:
          unawaited(messageController.showSnackBar(
            text: DialogStrings.otherErrorSnackBarText,
            context: context,
          ));
          break;
      }
      _listPlaceState.content([]);
    }
  }

  Future<void> _saveSetttings() async {
    await model.setFilterSettings(
      types: _filterState.value ?? <PlaceType>[],
      distance: _sliderState.value ?? _defaultSliderValue,
    );
  }
}
