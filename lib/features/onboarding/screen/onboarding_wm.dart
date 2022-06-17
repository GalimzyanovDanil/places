import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/navigation/domain/entity/app_coordinate.dart';
import 'package:places/features/navigation/service/coordinator.dart';
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
    coordinator: appScope.coordinator,
  );
}

/// Default widget model for OnboardingWidget
class OnboardingWidgetModel
    extends WidgetModel<OnboardingScreen, OnboardingModel>
    implements IOnboardingWidgetModel {
  final Coordinator coordinator;
  // Количество страниц онбординга
  final int _pageCount = 3;

  @override
  int get pageCount => _pageCount;

  late final PageController _pageController;

  final StateNotifier<bool> _isLastPage = StateNotifier<bool>(initValue: false);
  final StateNotifier<int> _currentPage = StateNotifier<int>(initValue: 0);

  @override
  PageController get pageController => _pageController;

  @override
  ListenableState<bool> get isLastPage => _isLastPage;

  @override
  ListenableState<int> get currentPage => _currentPage;

  OnboardingWidgetModel({
    required this.coordinator,
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
    if (coordinator.pages.length > 1) {
      coordinator.navigate(
        context,
        AppCoordinate.mainTabsScreen,
        replaceRootCoordinate: true,
      );
    } else {
      coordinator.navigate(
        context,
        AppCoordinate.mainTabsScreen,
        replaceCurrentCoordinate: true,
      );
    }
  }
}
