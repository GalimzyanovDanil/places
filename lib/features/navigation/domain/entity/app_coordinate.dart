import 'package:flutter/material.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/debug/screens/debug_screen/debug_screen.dart';
import 'package:places/features/main_tabs/screen/main_tabs_module/main_tabs_screen.dart';
import 'package:places/features/navigation/domain/entity/coordinate.dart';
import 'package:places/features/onboarding/screen/onboarding_screen.dart';
import 'package:places/features/place_details/screen/place_details_screen.dart';
import 'package:places/features/places_list/screen/add_place_module/add_place_screen.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_screen.dart';
import 'package:places/features/search/screen/search_screen.dart';
import 'package:places/features/splash_screen/screen/splash_screen.dart';

/// A set of routes for the entire app.
class AppCoordinate extends Coordinate {
  /// Initialization screens([]).
  static const initScreen = AppCoordinate._('init', true);

  ///Onboarding screen
  static const onboardingScreen = AppCoordinate._('onboarding', true);

  ///Filter settings screen
  static const filterSettingsScreen = AppCoordinate._('filter_settings', true);

  ///Main screen
  static const mainTabsScreen = AppCoordinate._('main_tabs', false);

  /// Debug screens([DebugScreen]).
  static const debugScreen = AppCoordinate._('debug_screen', true);

  ///Deatils screen
  static const detailsPlaceScreen = AppCoordinate._('details_place', true);

  ///Deatils screen
  static const searchScreen = AppCoordinate._('search', true);

  ///Deatils screen
  static const addPlaceScreen = AppCoordinate._('add_place', false);

  /// Initialization screens(it can be any screens).
  static const initial = initScreen;

  const AppCoordinate._(
    String value,
    bool isUnique,
  ) : super(
          value: value,
          isUnique: isUnique,
        );
}

final Map<String, AppCoordinate> appCoordinatesPaths = {
  '/main_tabs': AppCoordinate.mainTabsScreen,
  '/search': AppCoordinate.searchScreen,
};

/// List of main routes of the app.
final Map<AppCoordinate, CoordinateBuilder> appCoordinates = {
  AppCoordinate.initial: (_, __) => const SplashScreen(),
  AppCoordinate.debugScreen: (_, __) => const DebugScreen(),
  AppCoordinate.onboardingScreen: (_, __) => const OnboardingScreen(),
  AppCoordinate.mainTabsScreen: (_, __) => const MainTabsScreen(),
  AppCoordinate.filterSettingsScreen: (_, __) =>
      const FilterSettingsScreen(key: ValueKey('FilterSettingsScreen')),
  AppCoordinate.detailsPlaceScreen: (_, place) =>
      PlaceDetailsScreen(place: place as Place),
  AppCoordinate.searchScreen: (_, __) => const SearchScreen(),
  AppCoordinate.addPlaceScreen: (_, __) => const AddPlaceScreen(),
};
