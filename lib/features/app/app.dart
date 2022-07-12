import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:places/assets/themes/app_theme.dart';
import 'package:places/config/app_config.dart';
import 'package:places/config/debug_options.dart';
import 'package:places/config/environment/environment.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/common/widgets/di_scope/di_scope.dart';

/// App widget.
class App extends StatefulWidget {
  /// Create an instance App.
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late IAppScope _scope;

  @override
  void initState() {
    super.initState();

    _scope = AppScope(applicationRebuilder: _rebuildApplication);
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
            routeInformationParser: _scope.router.defaultRouteParser(),
            routerDelegate: _scope.router.delegate(),

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

  void _rebuildApplication() {
    setState(() {
      _scope = AppScope(applicationRebuilder: _rebuildApplication);
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
