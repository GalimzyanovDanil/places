import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/navigation/domain/entity/app_coordinate.dart';
import 'package:places/features/navigation/service/coordinator.dart';
import 'package:places/features/splash_screen/splash_model.dart';
import 'package:places/features/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

abstract class ISplashWidgetModel extends IWidgetModel {}

SplashWidgetModel defaultSplashWidgetModelFactory(BuildContext context) {
  final appScope = context.read<IAppScope>();
  final model = SplashModel(
    appSettingsService: appScope.appSettingsService,
    geopositionService: appScope.geopositionService,
  );
  return SplashWidgetModel(model: model, coordinator: appScope.coordinator);
}

// TODO: cover with documentation
/// Default widget model for SplashWidget
class SplashWidgetModel extends WidgetModel<SplashScreen, SplashModel>
    implements ISplashWidgetModel {
  SplashWidgetModel({required SplashModel model, required this.coordinator})
      : super(model);

  final Coordinator coordinator;
  late final bool isOnboardingFinish;

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _initialize();
  }

  Future<void> _initialize() async {
    isOnboardingFinish = await model.getOnboardingStatus();
    //TODO(me): Delete
    unawaited(Future<void>.delayed(const Duration(seconds: 1)).then((_) {
      _navigate();
    }));
  }

  void _navigate() {
    if (isOnboardingFinish) {
      coordinator.navigate(context, AppCoordinate.mainTabsScreen,
          replaceRootCoordinate: true);
    } else {
      coordinator.navigate(context, AppCoordinate.onboardingScreen,
          replaceRootCoordinate: true);
    }
  }
}
