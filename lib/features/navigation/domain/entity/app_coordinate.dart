import 'package:places/features/debug/screens/debug_screen/debug_screen.dart';
import 'package:places/features/navigation/domain/entity/coordinate.dart';
import 'package:places/features/onboarding/screen/onboarding_screen.dart';

/// A set of routes for the entire app.
class AppCoordinate extends Coordinate {
  /// Initialization screens([]).
  static const initScreen = AppCoordinate._('onboarding', true);

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
  AppCoordinate.initial: (_, __) => const OnboardingScreen(),
  AppCoordinate.debugScreen: (_, __) => const DebugScreen(),
};
