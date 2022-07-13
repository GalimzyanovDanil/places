import 'package:auto_route/auto_route.dart';
import 'package:elementary_test/elementary_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:places/features/common/service/app_settings_service.dart';
import 'package:places/features/navigation/app_router.dart';

import 'package:places/features/onboarding/screen/onboarding_model.dart';
import 'package:places/features/onboarding/screen/onboarding_screen.dart';
import 'package:places/features/onboarding/screen/onboarding_wm.dart';

class AppRouterMock extends Mock implements AppRouter {}

class AppSettingsServiceMock extends Mock implements AppSettingsService {}

class AutoRoutePageFake extends Fake implements AutoRoutePage<void> {}

void main() {
  group(
    'OnboardingWM',
    () {
      late AppSettingsService appSettingsServiceMock;
      late AppRouterMock appRouterMock;

      setUp(
        () {
          appSettingsServiceMock = AppSettingsServiceMock();
          appRouterMock = AppRouterMock();
        },
      );

      OnboardingWidgetModel setupWM() => OnboardingWidgetModel(
            router: appRouterMock,
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

          when(() => appRouterMock.stack).thenReturn([]);
          when(() => appRouterMock.replaceNamed(any<String>()))
              .thenAnswer((_) => Future.value());

          when(() => appRouterMock.pop<bool>(any<bool>()))
              .thenAnswer((_) => Future<bool>.value(false));

          wm.onSkipButton();
          verify(() =>
              appSettingsServiceMock.setOnboardingStatus(isComplete: true));

          final path = verify(() => appRouterMock.replaceNamed(captureAny()))
              .captured
              .first as String;
          expect(path, RoutesStrings.mainTabs);

          when(() => appRouterMock.stack).thenReturn([
            AutoRoutePageFake(),
            AutoRoutePageFake(),
          ]);

          wm.onSkipButton();
          await Future<void>.delayed(Duration.zero);

          verify(() => appRouterMock.pop(any<bool>()));
        },
      );
    },
  );
}
