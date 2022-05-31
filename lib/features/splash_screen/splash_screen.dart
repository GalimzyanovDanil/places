import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/splash_screen/splash_wm.dart';

// TODO: cover with documentation
/// Main widget for Splash module
class SplashScreen extends ElementaryWidget<ISplashWidgetModel> {
  const SplashScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultSplashWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISplashWidgetModel wm) {
    return const Center(
      child:
          SizedBox(height: 50, width: 50, child: CircularProgressIndicator()),
    );
  }
}
