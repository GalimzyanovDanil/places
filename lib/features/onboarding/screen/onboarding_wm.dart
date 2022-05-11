import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/onboarding/screen/onboarding_model.dart';
import 'package:places/features/onboarding/screen/onboarding_screen.dart';

abstract class IOnboardingWidgetModel extends IWidgetModel {
  PageController get pageController;
  TabController get tabController;
  ListenableState<bool> get isLastPage;
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
    with SingleTickerProviderWidgetModelMixin
    implements IOnboardingWidgetModel {
  late final PageController _pageController;
  late final TabController _tabController;
  final StateNotifier<bool> _isLastPage = StateNotifier<bool>(initValue: false);
  // Количество страниц онбординга
  final int _pageCount = 3;

  @override
  PageController get pageController => _pageController;

  @override
  TabController get tabController => _tabController;

  @override
  ListenableState<bool> get isLastPage => _isLastPage;

  OnboardingWidgetModel(OnboardingModel model) : super(model);

  @override
  void initWidgetModel() {
    _pageController = PageController();
    _tabController = TabController(length: _pageCount, vsync: this);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _tabController.dispose();
  }

  @override
  void onPageChanged(int index) {
    _isLastPage.accept(_pageCount - 1 == index);

    _tabController.animateTo(index);
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