import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:places/assets/colors/app_colors.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/features/splash_screen/screen/splash_wm.dart';

// TODO(me): cover with documentation
/// Main widget for Splash module
class SplashScreen extends ElementaryWidget<ISplashWidgetModel> {
  const SplashScreen({
    Key? key,
    WidgetModelFactory wmFactory = defaultSplashWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(ISplashWidgetModel wm) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.yellowSplash, AppColors.greenSplash],
        ),
      ),
      child: Center(
        child: RotationTransition(
          turns: wm.animation,
          child: SvgPicture.asset(
            AppAssets.iconSplashLogo,
            color: AppColors.whiteBase,
            width: 160,
            height: 160,
          ),
        ),
      ),
    );
  }
}
