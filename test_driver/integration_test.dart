import 'dart:io';

import 'package:integration_test/integration_test_driver.dart';

Future<void> main() async {
  const adbPath = '/Users/danil/Developer/Android/platform-tools/adb';

  await Process.run(adbPath, [
    'shell',
    'pm',
    'grant',
    'ru.surfstudio.flutterTemplate',
    'android.permission.ACCESS_FINE_LOCATION',
  ]);
  await Process.run(adbPath, [
    'shell',
    'pm',
    'grant',
    'ru.surfstudio.flutterTemplate',
    'android.permission.ACCESS_COARSE_LOCATION',
  ]);

  await integrationDriver();
}
