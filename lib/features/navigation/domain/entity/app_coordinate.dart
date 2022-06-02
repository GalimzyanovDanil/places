import 'package:places/features/debug/screens/debug_screen/debug_screen.dart';
import 'package:places/features/main_tabs/screen/main_tabs_module/main_tabs_screen.dart';
import 'package:places/features/navigation/domain/entity/coordinate.dart';
import 'package:places/features/onboarding/screen/onboarding_screen.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_screen.dart';
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
  static const mainTabsScreen = AppCoordinate._('main_tabs', true);

  /// Debug screens([DebugScreen]).
  static const debugScreen = AppCoordinate._('debug_screen', true);

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

/// List of main routes of the app.
final Map<AppCoordinate, CoordinateBuilder> appCoordinates = {
  AppCoordinate.initial: (_, __) => const SplashScreen(),
  AppCoordinate.debugScreen: (_, __) => const DebugScreen(),
  AppCoordinate.onboardingScreen: (_, __) => const OnboardingScreen(),
  AppCoordinate.mainTabsScreen: (_, __) => const MainTabsScreen(),
  AppCoordinate.filterSettingsScreen: (_, __) => const FilterSettingsScreen(),
};
