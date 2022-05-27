import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/favorite_list/screens/favorite_screen.dart';
import 'package:places/features/main_tabs/screen/main_tabs_module/main_tabs_wm.dart';
import 'package:places/features/main_tabs/widgets/svg_navigation_bar_item.dart';
import 'package:places/features/places_list/screen/places_list_module/places_list_screen.dart';
import 'package:places/features/settings/screen/settings_screen.dart';

// TODO: cover with documentation
/// Main widget for Settings module
class MainTabsScreen extends ElementaryWidget<IMainTabsWidgetModel> {
  const MainTabsScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultSettingsWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IMainTabsWidgetModel wm) {
    return Scaffold(
      body: TabBarView(
        controller: wm.tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          PlacesListScreen(),
          FavoriteScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: StateNotifierBuilder<int>(
          listenableState: wm.indexState,
          builder: (_, index) {
            final iconsColor = wm.colorScheme.onPrimaryContainer;

            return DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: wm.colorScheme.outline),
                ),
              ),
              child: BottomNavigationBar(
                items: [
                  SvgNavigationBarItem(
                    unselectedAssetName: AppAssets.iconList,
                    selectedAssetName: AppAssets.iconListFill,
                    iconColor: iconsColor,
                  ),
                  SvgNavigationBarItem(
                    unselectedAssetName: AppAssets.iconFavorite,
                    selectedAssetName: AppAssets.iconFavoriteFill,
                    iconColor: iconsColor,
                  ),
                  SvgNavigationBarItem(
                    unselectedAssetName: AppAssets.iconSettings,
                    selectedAssetName: AppAssets.iconSettingsFill,
                    iconColor: iconsColor,
                  ),
                ],
                currentIndex: index ?? 0,
                onTap: wm.onTapNavigation,
                enableFeedback: true,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                elevation: 0,
              ),
            );
          }),
    );
  }
}
