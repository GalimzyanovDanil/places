import 'dart:async';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/navigation/domain/entity/app_coordinate.dart';
import 'package:places/features/navigation/service/coordinator.dart';
import 'package:places/features/places_list/domain/entity/place.dart';
import 'package:places/features/places_list/domain/entity/place_type.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_model.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_screen.dart';
import 'package:places/features/places_list/widgets/filter_settings_widgets/category_element_widget.dart';
import 'package:provider/provider.dart';

abstract class IFilterSettingsWidgetModel extends IWidgetModel {
  ListenableState<EntityState<List<Place>>> get listPlaceState;
  ListenableState<double> get sliderState;
  ListenableState<List<PlaceType>> get filterState;
  double get minSliderValue;
  double get maxSliderValue;
  int get divSliderValue;
  void onBackButtonTap();
  void onClearTap();
  void onShowResultTap();
  void onSliderChange(double value);
  List<Widget> getCategoryElements();
}

FilterSettingsWidgetModel defaultFilterSettingsWidgetModelFactory(
    BuildContext context) {
  final appDependencies = context.read<IAppScope>();
  final model = FilterSettingsModel();
  return FilterSettingsWidgetModel(
    model: model,
    coordinator: appDependencies.coordinator,
  );
}

// TODO: cover with documentation
/// Default widget model for FilterSettingsWidget
class FilterSettingsWidgetModel
    extends WidgetModel<FilterSettingsScreen, FilterSettingsModel>
    implements IFilterSettingsWidgetModel {
  FilterSettingsWidgetModel({
    required FilterSettingsModel model,
    required this.coordinator,
  }) : super(model);

  final Coordinator coordinator;
  // Максимальное значение слайдера
  final _maxSliderValue = 30.0;
  // Минимальное значение слайдера
  final _minSliderValue = 10.0;
  // Значение шага слайдера
  final divisionStep = 1.0;
  //Значение слайдера по умолчанию
  static const _defaultSliderValue = 15.0;
  //Таймер для задержки отправки запроса на сервер
  Timer? _searchDebounced;
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

  //TODO: Получение начальных фильтров widget.
  final _filterState = StateNotifier<List<PlaceType>>(initValue: <PlaceType>[]);
  //TODO: Получение начальных значений слайдера widget.
  final _sliderState = StateNotifier<double>(initValue: _defaultSliderValue);

  final _listPlaceState = EntityStateNotifier<List<Place>>();

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
  int get divSliderValue => (_maxSliderValue - _minSliderValue) ~/ divisionStep;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _loadPlaceList();
  }

  // Загрузка данных по данным фильтра с задержкой или без
  Future<void> _loadPlaceListDebounce() async {
    _searchDebounced?.cancel();
    _searchDebounced = Timer(const Duration(milliseconds: 800), () async {
      await _loadPlaceList();
    });
  }

  Future<void> _loadPlaceList() async {
    _listPlaceState.loading();
    //TODO Загрузка данных
    await Future<void>.delayed(const Duration(seconds: 2));
    _listPlaceState.content(<Place>[]);
  }

  @override
  void onBackButtonTap() {
    Navigator.of(context).pop();
  }

  @override
  void onClearTap() {
    _filterState.accept(List<PlaceType>.from(<PlaceType>[]));
    _sliderState.accept(_defaultSliderValue);
    _loadPlaceListDebounce();
  }

  @override
  void onShowResultTap() {
    coordinator.navigate(
      context,
      AppCoordinate.placesScreen,
      replaceCurrentCoordinate: true,
      replaceRootCoordinate: true,
      //TODO arguments = FILTER SETTING  + List<Places>
      arguments: _listPlaceState.value?.data,
    );
  }

  @override
  void onSliderChange(double value) {
    _sliderState.accept(value);
    _loadPlaceListDebounce();
  }

  @override
  List<Widget> getCategoryElements() {
    final result = allPlaceType.map<CategoryElementWidget>((type) {
      final isSelect = _filterState.value?.contains(type) ?? false;

      switch (type) {
        case PlaceType.park:
          return CategoryElementWidget(
            iconPath: AppAssets.iconPark,
            isSelect: isSelect,
            onElementTap: _onElementTap,
            placeType: type,
          );
        case PlaceType.museum:
          return CategoryElementWidget(
              iconPath: AppAssets.iconMuseum,
              isSelect: isSelect,
              onElementTap: _onElementTap,
              placeType: type);
        case PlaceType.hotel:
          return CategoryElementWidget(
              iconPath: AppAssets.iconHotel,
              isSelect: isSelect,
              onElementTap: _onElementTap,
              placeType: type);
        case PlaceType.restaurant:
          return CategoryElementWidget(
              iconPath: AppAssets.iconRestourant,
              isSelect: isSelect,
              onElementTap: _onElementTap,
              placeType: type);
        case PlaceType.cafe:
          return CategoryElementWidget(
              iconPath: AppAssets.iconCafe,
              isSelect: isSelect,
              onElementTap: _onElementTap,
              placeType: type);
        case PlaceType.other:
          return CategoryElementWidget(
              iconPath: AppAssets.iconParticularPlace,
              isSelect: isSelect,
              onElementTap: _onElementTap,
              placeType: type);
        default:
          throw UnimplementedError();
      }
    });

    return result.toList();
  }

  // Обработка нажатия на элемент фильтра
  void _onElementTap(bool isSel, PlaceType type) {
    if (isSel) {
      _filterState.value?.remove(type);
      _filterState.accept(
        List<PlaceType>.from(_filterState.value ?? <PlaceType>[]),
      );
    } else {
      _filterState.value?.add(type);
      _filterState.accept(
        List<PlaceType>.from(_filterState.value ?? <PlaceType>[]),
      );
    }
    _loadPlaceListDebounce();
  }
}