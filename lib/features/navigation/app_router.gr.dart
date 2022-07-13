// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashPageRoute.name: (routeData) {
      return MaterialPageX<void>(
          routeData: routeData, child: const SplashPage());
    },
    DebugPageRoute.name: (routeData) {
      return MaterialPageX<void>(
          routeData: routeData, child: const DebugPage());
    },
    OnboardingPageRoute.name: (routeData) {
      return MaterialPageX<void>(
          routeData: routeData, child: const OnboardingPage());
    },
    MainTabsPageRoute.name: (routeData) {
      return MaterialPageX<void>(
          routeData: routeData, child: const MainTabsPage());
    },
    FilterSettingsPageRoute.name: (routeData) {
      return MaterialPageX<bool>(
          routeData: routeData, child: const FilterSettingsPage());
    },
    PlaceDetailsPageRoute.name: (routeData) {
      final args = routeData.argsAs<PlaceDetailsPageRouteArgs>();
      return MaterialPageX<bool>(
          routeData: routeData,
          child: PlaceDetailsPage(place: args.place, key: args.key));
    },
    SearchPageRoute.name: (routeData) {
      return MaterialPageX<void>(
          routeData: routeData, child: const SearchPage());
    },
    AddPlacePageRoute.name: (routeData) {
      return MaterialPageX<void>(
          routeData: routeData, child: const AddPlacePage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(SplashPageRoute.name, path: '/'),
        RouteConfig(DebugPageRoute.name, path: 'debug'),
        RouteConfig(OnboardingPageRoute.name, path: 'onboarding'),
        RouteConfig(MainTabsPageRoute.name, path: 'mainTabs'),
        RouteConfig(FilterSettingsPageRoute.name, path: 'filterSettings'),
        RouteConfig(PlaceDetailsPageRoute.name, path: 'placeDetails'),
        RouteConfig(SearchPageRoute.name, path: 'search'),
        RouteConfig(AddPlacePageRoute.name, path: 'addPlace')
      ];
}

/// generated route for
/// [SplashPage]
class SplashPageRoute extends PageRouteInfo<void> {
  const SplashPageRoute() : super(SplashPageRoute.name, path: '/');

  static const String name = 'SplashPageRoute';
}

/// generated route for
/// [DebugPage]
class DebugPageRoute extends PageRouteInfo<void> {
  const DebugPageRoute() : super(DebugPageRoute.name, path: 'debug');

  static const String name = 'DebugPageRoute';
}

/// generated route for
/// [OnboardingPage]
class OnboardingPageRoute extends PageRouteInfo<void> {
  const OnboardingPageRoute()
      : super(OnboardingPageRoute.name, path: 'onboarding');

  static const String name = 'OnboardingPageRoute';
}

/// generated route for
/// [MainTabsPage]
class MainTabsPageRoute extends PageRouteInfo<void> {
  const MainTabsPageRoute() : super(MainTabsPageRoute.name, path: 'mainTabs');

  static const String name = 'MainTabsPageRoute';
}

/// generated route for
/// [FilterSettingsPage]
class FilterSettingsPageRoute extends PageRouteInfo<void> {
  const FilterSettingsPageRoute()
      : super(FilterSettingsPageRoute.name, path: 'filterSettings');

  static const String name = 'FilterSettingsPageRoute';
}

/// generated route for
/// [PlaceDetailsPage]
class PlaceDetailsPageRoute extends PageRouteInfo<PlaceDetailsPageRouteArgs> {
  PlaceDetailsPageRoute({required Place place, Key? key})
      : super(PlaceDetailsPageRoute.name,
            path: 'placeDetails',
            args: PlaceDetailsPageRouteArgs(place: place, key: key));

  static const String name = 'PlaceDetailsPageRoute';
}

class PlaceDetailsPageRouteArgs {
  const PlaceDetailsPageRouteArgs({required this.place, this.key});

  final Place place;

  final Key? key;

  @override
  String toString() {
    return 'PlaceDetailsPageRouteArgs{place: $place, key: $key}';
  }
}

/// generated route for
/// [SearchPage]
class SearchPageRoute extends PageRouteInfo<void> {
  const SearchPageRoute() : super(SearchPageRoute.name, path: 'search');

  static const String name = 'SearchPageRoute';
}

/// generated route for
/// [AddPlacePage]
class AddPlacePageRoute extends PageRouteInfo<void> {
  const AddPlacePageRoute() : super(AddPlacePageRoute.name, path: 'addPlace');

  static const String name = 'AddPlacePageRoute';
}
