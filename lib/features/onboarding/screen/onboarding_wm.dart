import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/onboarding/screen/onboarding_model.dart';
import 'package:places/features/onboarding/screen/onboarding_screen.dart';

abstract class IOnboardingWidgetModel extends IWidgetModel {}

OnboardingWidgetModel defaultOnboardingWidgetModelFactory(
    BuildContext context) {
  return OnboardingWidgetModel(OnboardingModel());
}

// TODO: cover with documentation
/// Default widget model for OnboardingWidget
class OnboardingWidgetModel
    extends WidgetModel<OnboardingScreen, OnboardingModel>
    implements IOnboardingWidgetModel {
  OnboardingWidgetModel(OnboardingModel model) : super(model);
}
