import 'dart:async';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/common/service/geoposition_service.dart';
import 'package:places/features/common/strings/alert_dialog_strings.dart';
import 'package:places/features/common/widgets/alert_dialog/alert_dialog_widget_factory.dart';
import 'package:places/features/navigation/domain/entity/app_coordinate.dart';
import 'package:places/features/navigation/service/coordinator.dart';
import 'package:places/features/splash_screen/screen/splash_model.dart';
import 'package:places/features/splash_screen/screen/splash_screen.dart';
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

    await _geopositionChecks();
    _navigate();
  }

  //
  Future<void> _geopositionChecks() async {
    var status = GeopositionStatus.ok;
    status = await model.isCheckPermission();

    if (status == GeopositionStatus.denied) {
      status = await model.requsetAndIsCheckPermission();
    }

    switch (status) {
      case GeopositionStatus.denied:
      case GeopositionStatus.deniedForever:
        return;
      case GeopositionStatus.ok:
        await _isLocationServiceEnabled();
        return;
    }
  }

  //
  Future<void> _isLocationServiceEnabled() async {
    var isEnabled = false;
    isEnabled = await model.isLocationServiceEnabled();
    if (!isEnabled) {
      await _showMyDialog(
          alertDialogWidget: alertDialogWidgetFactory(
        title: AlertDialogStrings.title,
        bodyText: AlertDialogStrings.geoServiceNotEnabledText,
        confirmTitle: AlertDialogStrings.confirmText,
        declineTitle: AlertDialogStrings.declineText,
        onConfirm: model.openSettings,
      ));
    }
    return;
  }

  //
  void _navigate() {
    if (isMounted) {
      if (isOnboardingFinish) {
        coordinator.navigate(context, AppCoordinate.mainTabsScreen,
            replaceRootCoordinate: true);
      } else {
        coordinator.navigate(context, AppCoordinate.onboardingScreen,
            replaceRootCoordinate: true);
      }
    }
  }

  //
  Future<void> _showMyDialog({required Widget alertDialogWidget}) async {
    if (isMounted) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return alertDialogWidget;
        },
      );
    }
  }
}
