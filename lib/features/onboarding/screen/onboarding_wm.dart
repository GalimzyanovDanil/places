import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/navigation/app_router.dart';
import 'package:places/features/onboarding/screen/onboarding_model.dart';
import 'package:places/features/onboarding/screen/onboarding_screen.dart';
import 'package:provider/provider.dart';

abstract class IOnboardingWidgetModel extends IWidgetModel {
  PageController get pageController;
  ListenableState<bool> get isLastPage;
  ListenableState<int> get currentPage;
  int get pageCount;
  void onPageChanged(int index);
  void onSkipButton();
  void onStartButton();
}

OnboardingWidgetModel defaultOnboardingWidgetModelFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();
  final model = OnboardingModel(appScope.appSettingsService);
  return OnboardingWidgetModel(
    model: model,
    router: appScope.router,
  );
}

/// Default widget model for OnboardingWidget
class OnboardingWidgetModel
    extends WidgetModel<OnboardingScreen, OnboardingModel>
    implements IOnboardingWidgetModel {
  final AppRouter router;
  // Количество страниц онбординга
  final int _pageCount = 3;

  late final PageController _pageController;

  final StateNotifier<bool> _isLastPage = StateNotifier<bool>(initValue: false);
  final StateNotifier<int> _currentPage = StateNotifier<int>(initValue: 0);

  @override
  int get pageCount => _pageCount;

  @override
  PageController get pageController => _pageController;

  @override
  ListenableState<bool> get isLastPage => _isLastPage;

  @override
  ListenableState<int> get currentPage => _currentPage;

  OnboardingWidgetModel({
    required this.router,
    required OnboardingModel model,
  }) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _pageController = PageController();
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
    _finishOnboarding();
  }

  @override
  void onStartButton() {
    _finishOnboarding();
  }

  void _finishOnboarding() {
    model.setOnboardingStatus(isComplete: true);
    _nextScreen();
  }

  void _nextScreen() {
    if (router.stack.length > 1) {
      router.pop(true);
    } else {
      router.replaceNamed(RoutesStrings.mainTabs);
    }
  }
}
