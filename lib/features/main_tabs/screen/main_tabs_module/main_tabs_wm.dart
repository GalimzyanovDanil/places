import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/main_tabs/screen/main_tabs_module/main_tabs_model.dart';
import 'package:places/features/main_tabs/screen/main_tabs_module/main_tabs_screen.dart';

abstract class IMainTabsWidgetModel extends IWidgetModel {
  ListenableState<int> get indexState;
  TabController get tabController;
  ColorScheme get colorScheme;
  void onTapNavigation(int index);
}

MainTabsWidgetModel defaultSettingsWidgetModelFactory(BuildContext context) {
  final model = MainTabsModel();
  return MainTabsWidgetModel(model);
}

// TODO: cover with documentation
/// Default widget model for SettingsWidget
class MainTabsWidgetModel extends WidgetModel<MainTabsScreen, MainTabsModel>
    with TickerProviderWidgetModelMixin<MainTabsScreen, MainTabsModel>
    implements IMainTabsWidgetModel {
  MainTabsWidgetModel(MainTabsModel model) : super(model);

  late final TabController _tabController;
  final _indexState = StateNotifier<int>(initValue: 0);
  //Количество иконок меню
  final navigationItemCount = 3;
  @override
  TabController get tabController => _tabController;

  @override
  ListenableState<int> get indexState => _indexState;

  @override
  ColorScheme get colorScheme => Theme.of(context).colorScheme;

  @override
  void onTapNavigation(int index) {
    _tabController.index = index;
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _tabController = TabController(length: navigationItemCount, vsync: this)
      ..addListener(() {
        _indexState.accept(_tabController.index);
      });
  }
}
