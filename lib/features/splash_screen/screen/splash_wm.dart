import 'dart:async';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/navigation/domain/entity/app_coordinate.dart';
import 'package:places/features/navigation/service/coordinator.dart';
import 'package:places/features/splash_screen/screen/splash_model.dart';
import 'package:places/features/splash_screen/screen/splash_screen.dart';
import 'package:provider/provider.dart';

abstract class ISplashWidgetModel extends IWidgetModel {
  Animation<double> get animation;
}

SplashWidgetModel defaultSplashWidgetModelFactory(BuildContext context) {
  final appScope = context.read<IAppScope>();
  final model = SplashModel(appSettingsService: appScope.appSettingsService);
  return SplashWidgetModel(model: model, coordinator: appScope.coordinator);
}

// TODO(me): cover with documentation
/// Default widget model for SplashWidget
class SplashWidgetModel extends WidgetModel<SplashScreen, SplashModel>
    with TickerProviderWidgetModelMixin
    implements ISplashWidgetModel {
  final Coordinator coordinator;

  late final bool isOnboardingFinish;
  late final Animation<double> _animation;
  late final AnimationController _controller;

  @override
  Animation<double> get animation => _animation;

  SplashWidgetModel({required SplashModel model, required this.coordinator})
      : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0,
      end: -1,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.repeat();

    _initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _initialize() async {
    isOnboardingFinish = await model.getOnboardingStatus();
    await Future<void>.delayed(const Duration(seconds: 3))
        .whenComplete(() async {
      _navigate();
    });
  }

  void _navigate() {
    if (isMounted) {
      if (isOnboardingFinish) {
        coordinator.navigate(
          context,
          AppCoordinate.mainTabsScreen,
          replaceRootCoordinate: true,
        );
      } else {
        coordinator.navigate(
          context,
          AppCoordinate.onboardingScreen,
          replaceRootCoordinate: true,
        );
      }
    }
  }
}
