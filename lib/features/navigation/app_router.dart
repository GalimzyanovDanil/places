import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/debug/screens/debug_screen/debug_screen.dart';
import 'package:places/features/main_tabs/screen/main_tabs_module/main_tabs_screen.dart';
import 'package:places/features/onboarding/screen/onboarding_screen.dart';
import 'package:places/features/place_details/screen/place_details_screen.dart';
import 'package:places/features/places_list/screen/add_place_module/add_place_screen.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_screen.dart';
import 'package:places/features/search/screen/search_screen.dart';
import 'package:places/features/splash_screen/screen/splash_screen.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute<void>(
      page: SplashPage,
      initial: true,
    ),
    AutoRoute<void>(
      page: DebugPage,
      path: RoutesStrings.debug,
    ),
    AutoRoute<void>(
      page: OnboardingPage,
      path: RoutesStrings.onboarding,
    ),
    AutoRoute<void>(
      page: MainTabsPage,
      path: RoutesStrings.mainTabs,
    ),
    AutoRoute<bool>(
      page: FilterSettingsPage,
      path: RoutesStrings.filterSettings,
    ),
    AutoRoute<bool>(
      page: PlaceDetailsPage,
      path: RoutesStrings.placeDetails,
    ),
    AutoRoute<void>(
      page: SearchPage,
      path: RoutesStrings.search,
    ),
    AutoRoute<void>(
      page: AddPlacePage,
      path: RoutesStrings.addPlace,
    ),
  ],
)
class AppRouter extends _$AppRouter {
  static final AppRouter _router = AppRouter._();

  AppRouter._();

  /// Singleton instance of [AppRouter]
  factory AppRouter.instance() => _router;
}

abstract class RoutesStrings {
  static const debug = 'debug';
  static const onboarding = 'onboarding';
  static const mainTabs = 'mainTabs';
  static const filterSettings = 'filterSettings';
  static const placeDetails = 'placeDetails';
  static const search = 'search';
  static const addPlace = 'addPlace';
}

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const SplashScreen();
}

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const OnboardingScreen();
}

class MainTabsPage extends StatelessWidget {
  const MainTabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MainTabsScreen();
}

class DebugPage extends StatelessWidget {
  const DebugPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const DebugScreen();
}

class FilterSettingsPage extends StatelessWidget {
  const FilterSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const FilterSettingsScreen();
  }
}

class PlaceDetailsPage extends StatelessWidget {
  final Place place;
  const PlaceDetailsPage({required this.place, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlaceDetailsScreen(place: place);
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SearchScreen();
  }
}

class AddPlacePage extends StatelessWidget {
  const AddPlacePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AddPlaceScreen();
  }
}
