import 'dart:async';

import 'dart:ui';
import 'package:golden_toolkit/golden_toolkit.dart';

const _defaultDevices = [
  Device(size: Size(375, 667), name: 'iPhone SE 2022', devicePixelRatio: 2),
  Device(size: Size(375, 812), name: 'iPhone 13 Mini', devicePixelRatio: 2),
  Device(size: Size(390, 844), name: 'iPhone 13', devicePixelRatio: 3),
  Device(size: Size(428, 926), name: 'iPhone 13 Pro Max', devicePixelRatio: 3),
  Device(size: Size(360, 800), name: 'Samsung S20', devicePixelRatio: 4),
  Device(size: Size(360, 800), name: 'Samsung S20', devicePixelRatio: 4),
  Device(size: Size(1180, 820), name: 'iPad Air', devicePixelRatio: 2),
];

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return GoldenToolkit.runWithConfiguration(
    () async {
      await loadAppFonts();
      await testMain();
    },
    config: GoldenToolkitConfiguration(
      defaultDevices: _defaultDevices,
      enableRealShadows: true,
    ),
  );
}
