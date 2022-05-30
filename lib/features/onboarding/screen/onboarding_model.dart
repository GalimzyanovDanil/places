import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:places/features/common/service/local_storage_service.dart';
import 'package:places/features/onboarding/screen/onboarding_screen.dart';

/// Model fol [OnboardingScreen].
class OnboardingModel extends ElementaryModel {
  OnboardingModel(this._localStorageService) : super();
  final LocalStorageService _localStorageService;

  Future<void> setOnboardingStatus({required bool isComplete}) async {
    unawaited(_localStorageService.setOnboardingStatus(isComplete: isComplete));
  }

  Future<bool?> getOnboardingStatus() async {
    return _localStorageService.getOnboardingStatus();
  }

  //TODO Перенести в сплешскрин
  Future<bool?> getTheme() async {
    return _localStorageService.getTheme();
  }
}
