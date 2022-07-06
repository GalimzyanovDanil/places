import 'package:elementary_test/elementary_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:places/features/common/service/app_settings_service.dart';
import 'package:places/features/navigation/domain/entity/app_coordinate.dart';
import 'package:places/features/navigation/service/coordinator.dart';
import 'package:places/features/onboarding/screen/onboarding_model.dart';
import 'package:places/features/onboarding/screen/onboarding_screen.dart';
import 'package:places/features/onboarding/screen/onboarding_wm.dart';

class CoordinatorMock extends Mock implements Coordinator {}

class AppSettingsServiceMock extends Mock implements AppSettingsService {}

void main() {
  group(
    'OnboardingWM',
    () {
      late AppSettingsService appSettingsServiceMock;
      late Coordinator coordinatorMock;

      setUp(
        () {
          appSettingsServiceMock = AppSettingsServiceMock();
          coordinatorMock = CoordinatorMock();
        },
      );

      OnboardingWidgetModel setupWM() => OnboardingWidgetModel(
            coordinator: coordinatorMock,
            model: OnboardingModel(appSettingsServiceMock),
          );

      testWidgetModel<OnboardingWidgetModel, OnboardingScreen>(
        'Test init WM',
        setupWM,
        (wm, tester, context) {
          tester.init();
        },
      );

      testWidgetModel<OnboardingWidgetModel, OnboardingScreen>(
        'Test state getters',
        setupWM,
        (wm, tester, context) {
          tester.init();
          wm.onPageChanged(1);
          expect(wm.currentPage.value, 1);
          wm.onPageChanged(wm.pageCount - 1);
          expect(wm.isLastPage.value, isTrue);
        },
      );

      testWidgetModel<OnboardingWidgetModel, OnboardingScreen>(
        'Test PageController',
        setupWM,
        (wm, tester, context) {
          tester.init();
          expect(wm.pageController, isNotNull);
        },
      );

      testWidgetModel<OnboardingWidgetModel, OnboardingScreen>(
        'Navigation on MainTabs',
        setupWM,
        (wm, tester, context) async {
          tester.init();

          when(() =>
                  appSettingsServiceMock.setOnboardingStatus(isComplete: true))
              .thenAnswer((_) => Future.value());

          when(() => coordinatorMock.pages).thenReturn([]);

          wm.onSkipButton();
          verify(() =>
              appSettingsServiceMock.setOnboardingStatus(isComplete: true));

          verify(() => coordinatorMock.navigate(
                context,
                AppCoordinate.mainTabsScreen,
                replaceCurrentCoordinate: true,
              ));

          when(() => coordinatorMock.pages).thenReturn([
            const MaterialPage<dynamic>(child: Center()),
            const MaterialPage<dynamic>(child: Center()),
          ]);
          wm.onSkipButton();
          verify(() => coordinatorMock.navigate(
                context,
                AppCoordinate.mainTabsScreen,
                replaceRootCoordinate: true,
              ));
        },
      );
    },
  );
}
