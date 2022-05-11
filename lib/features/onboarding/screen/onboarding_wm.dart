import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/onboarding/screen/onboarding_model.dart';
import 'package:places/features/onboarding/screen/onboarding_screen.dart';

abstract class IOnboardingWidgetModel extends IWidgetModel {
  PageController get pageController;
  ListenableState<bool> get isLastPage;
  ListenableState<int> get currentPage;
  void onPageChanged(int index);
  void onSkipButton();
  void onStartButton();
}

OnboardingWidgetModel defaultOnboardingWidgetModelFactory(
  BuildContext context,
) {
  return OnboardingWidgetModel(OnboardingModel());
}

/// Default widget model for OnboardingWidget
class OnboardingWidgetModel
    extends WidgetModel<OnboardingScreen, OnboardingModel>
    implements IOnboardingWidgetModel {
  late final PageController _pageController;

  final StateNotifier<bool> _isLastPage = StateNotifier<bool>(initValue: false);
  final StateNotifier<int> _currentPage = StateNotifier<int>(initValue: 0);
  // Количество страниц онбординга
  final int _pageCount = 3;

  @override
  PageController get pageController => _pageController;

  @override
  ListenableState<bool> get isLastPage => _isLastPage;

  @override
  ListenableState<int> get currentPage => _currentPage;

  OnboardingWidgetModel(OnboardingModel model) : super(model);

  @override
  void initWidgetModel() {
    _pageController = PageController();
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  void onPageChanged(int index) {
    _isLastPage.accept(_pageCount - 1 == index);
    _currentPage.accept(index);
  }

  @override
  void onSkipButton() {
    // TODO: implement onSkipButton
    debugPrint('OnSkipButton Pressed');
  }

  @override
  void onStartButton() {
    // TODO: implement onStartButton
    debugPrint('OnStartButton Pressed');
  }
}
