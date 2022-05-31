import 'dart:async';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
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
  ThemeData get theme;
  double get minSliderValue;
  double get maxSliderValue;
  void onBackButtonTap();
  void onClearTap();
  void onShowResultTap();
  void onSliderChange(double value);
  List<Widget> getCategoryElements();
}

FilterSettingsWidgetModel defaultFilterSettingsWidgetModelFactory(
    BuildContext context) {
  final appDependencies = context.read<IAppScope>();
  final appSettingsService = appDependencies.appSettingsService;
  final model = FilterSettingsModel(appSettingsService);
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
  //Значение слайдера по умолчанию
  static const _defaultSliderValue = 10.0;
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
  final StateNotifier<List<PlaceType>> _filterState =
      StateNotifier<List<PlaceType>>(initValue: <PlaceType>[]);
  //TODO: Получение начальных значений слайдера widget.
  final StateNotifier<double> _sliderState =
      StateNotifier<double>(initValue: _defaultSliderValue);

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
  ThemeData get theme => Theme.of(context);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _loadPlaceList();
    _initFilterSettings();
  }

  Future<void> _initFilterSettings() async {
    final initialFilterTypes = await model.getFilterPlaceTypes();
    final initialFilterDistance = await model.getFilterDistance();
    _filterState.accept(initialFilterTypes ?? allPlaceType.toList());
    _sliderState.accept(initialFilterDistance ?? _defaultSliderValue);
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
    //TODO(me): Загрузка данных
    await Future<void>.delayed(const Duration(seconds: 2));
    _listPlaceState.content(<Place>[]);
  }

  @override
  void onBackButtonTap() {
    //TODO(me): Удалить saveSettings
    saveSetttings();
    Navigator.of(context).pop();
  }

  Future<void> saveSetttings() async {
    await model.setFilterSettings(
      types: _filterState.value ?? <PlaceType>[],
      distance: _sliderState.value ?? _defaultSliderValue,
    );
  }

  @override
  void onClearTap() {
    _filterState.accept(List<PlaceType>.from(<PlaceType>[]));
    _sliderState.accept(_defaultSliderValue);
    _loadPlaceListDebounce();
  }

  @override
  void onShowResultTap() {
    saveSetttings();
    coordinator.navigate(
      context,
      AppCoordinate.mainTabsScreen,
      replaceCurrentCoordinate: true,
      replaceRootCoordinate: true,
    );
  }

  @override
  void onSliderChange(double value) {
    _sliderState.accept(value);
    _loadPlaceListDebounce();
  }

  @override
  List<Widget> getCategoryElements() {
    final result = allPlaceType.map<CategoryElementWidget>(
      (type) => CategoryElementWidget(
        iconPath: type.iconPath,
        isSelect: _filterState.value?.contains(type) ?? false,
        onElementTap: _onElementTap,
        placeType: type,
      ),
    );
    return result.toList();
  }

  // Обработка нажатия на элемент фильтра
  void _onElementTap(bool isSel, PlaceType type) {
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
}
