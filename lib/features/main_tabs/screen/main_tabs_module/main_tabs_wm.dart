import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/main_tabs/screen/main_tabs_module/main_tabs_model.dart';
import 'package:places/features/main_tabs/screen/main_tabs_module/main_tabs_screen.dart';
import 'package:provider/provider.dart';

abstract class IMainTabsWidgetModel extends IWidgetModel {
  ListenableState<int> get indexState;
  TabController get tabController;
  ColorScheme get colorScheme;
  void onTapNavigation(int index);
}

MainTabsWidgetModel defaultSettingsWidgetModelFactory(BuildContext context) {
  final appScope = context.read<IAppScope>();
  final model = MainTabsModel(appScope.appSettingsService);
  return MainTabsWidgetModel(model);
}

// TODO(me): cover with documentation
/// Default widget model for SettingsWidget
class MainTabsWidgetModel extends WidgetModel<MainTabsScreen, MainTabsModel>
    with TickerProviderWidgetModelMixin<MainTabsScreen, MainTabsModel>
    implements IMainTabsWidgetModel {
  late final TabController _tabController;
  //Количество иконок меню
  final _navigationItemCount = 3;

  final _indexState = StateNotifier<int>(initValue: 0);

  @override
  TabController get tabController => _tabController;

  @override
  ListenableState<int> get indexState => _indexState;

  @override
  ColorScheme get colorScheme => Theme.of(context).colorScheme;

  MainTabsWidgetModel(MainTabsModel model) : super(model);

  @override
  void onTapNavigation(int index) {
    _tabController.index = index;
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _tabController = TabController(length: _navigationItemCount, vsync: this)
      ..addListener(() {
        _indexState.accept(_tabController.index);
        model.setTabIndex(_tabController.index);
      });

    _restoreTabIndex();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _restoreTabIndex() async {
    final lastTapIndex = model.getTabIndex();
    _tabController.index = lastTapIndex ?? 0;
  }
}
