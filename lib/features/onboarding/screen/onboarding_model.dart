import 'dart:async';
import 'package:elementary/elementary.dart';
import 'package:places/features/common/service/app_settings_service.dart';
import 'package:places/features/onboarding/screen/onboarding_screen.dart';

/// Model fol [OnboardingScreen].
class OnboardingModel extends ElementaryModel {
  OnboardingModel(this.appSettingsService) : super();
  final AppSettingsService appSettingsService;

  Future<void> setOnboardingStatus({required bool isComplete}) async {
    unawaited(appSettingsService.setOnboardingStatus(isComplete: isComplete));
  }
}
