import 'package:places/config/app_config.dart';
import 'package:places/config/debug_options.dart';
import 'package:places/config/environment/build_types.dart';
import 'package:places/config/environment/environment.dart';
import 'package:places/config/urls.dart';
import 'package:places/runner.dart';

/// Main entry point of app.
void main() {
  Environment.init(
    buildType: BuildType.debug,
    config: AppConfig(
      url: Url.testUrl,
      proxyUrl: Url.devProxyUrl,
      debugOptions: DebugOptions(
        debugShowCheckedModeBanner: true,
      ),
    ),
  );

  run();
}
