import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:places/assets/themes/app_theme.dart';
import 'package:places/config/app_config.dart';
import 'package:places/config/debug_options.dart';
import 'package:places/config/environment/environment.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/common/widgets/di_scope/di_scope.dart';
import 'package:places/features/navigation/app_router.dart';
import 'package:places/features/navigation/domain/delegate/app_router_delegate.dart';
import 'package:places/features/navigation/domain/entity/app_coordinate.dart';
import 'package:places/features/navigation/domain/parser/app_route_information_parses.dart';
import 'package:places/features/navigation/service/coordinator.dart';

/// App widget.
class App extends StatefulWidget {
  /// Create an instance App.
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late IAppScope _scope;
  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();

    _scope = AppScope(applicationRebuilder: _rebuildApplication);

    _setupRouting(_scope.coordinator);

    _appRouter = AppRouter();
  }

  @override
  void dispose() {
    _scope.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DiScope<IAppScope>(
      key: ObjectKey(_scope),
      factory: () {
        return _scope;
      },
      child: StreamBuilder<bool>(
        stream: _scope.appSettingsService.themeStream,
        builder: (context, value) {
          return MaterialApp.router(
            /// Localization.
            locale: _localizations.first,
            localizationsDelegates: _localizationsDelegates,
            supportedLocales: _localizations,

            /// Debug configuration.
            showPerformanceOverlay: _getDebugConfig().showPerformanceOverlay,
            debugShowMaterialGrid: _getDebugConfig().debugShowMaterialGrid,
            checkerboardRasterCacheImages:
                _getDebugConfig().checkerboardRasterCacheImages,
            checkerboardOffscreenLayers:
                _getDebugConfig().checkerboardOffscreenLayers,
            showSemanticsDebugger: _getDebugConfig().showSemanticsDebugger,
            debugShowCheckedModeBanner:
                _getDebugConfig().debugShowCheckedModeBanner,

            /// This is for navigation.
            routeInformationParser: _appRouter.defaultRouteParser(),
            routerDelegate: _appRouter.delegate(),

            /// Theme
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: (value.data ?? false) ? ThemeMode.dark : ThemeMode.light,
          );
        },
      ),
    );
  }

  DebugOptions _getDebugConfig() {
    return Environment<AppConfig>.instance().config.debugOptions;
  }

  void _setupRouting(Coordinator coordinator) {
    coordinator
      ..initialCoordinate = AppCoordinate.initial
      ..registerCoordinates('/', appCoordinates);
  }

  void _rebuildApplication() {
    setState(() {
      _scope = AppScope(applicationRebuilder: _rebuildApplication);
      _setupRouting(_scope.coordinator);
    });
  }
}

// You need to customize for your project.
const _localizations = [Locale('ru', 'RU')];

const _localizationsDelegates = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
