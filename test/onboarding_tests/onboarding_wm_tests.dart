import 'package:elementary_test/elementary_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:places/features/navigation/service/coordinator.dart';
import 'package:places/features/onboarding/screen/onboarding_model.dart';
import 'package:places/features/onboarding/screen/onboarding_screen.dart';
import 'package:places/features/onboarding/screen/onboarding_wm.dart';

Future<void> onboardingWidgetModelTest() async {
  group(
    'Инициилизация онобрдинг WM',
    () {
      setUp(() {
        // Некие настройки до тестов. Например DI
      });

      test(
        'Создание WM',
        () {
          expect(
            () => defaultOnboardingWidgetModelFactory(BuildContextMock()),
            returnsNormally,
          );
        },
      );
    },
  );
  group(
    'Онбординг WM тесты',
    () {
      late OnboardingModelMock onboardingModelMock;

      OnboardingWidgetModel setupWM() {
        onboardingModelMock = OnboardingModelMock();
        final coordinator = Coordinator();
        return OnboardingWidgetModel(
          model: onboardingModelMock,
          coordinator: coordinator,
        );
      }

      testWidgetModel<OnboardingWidgetModel, OnboardingScreen>(
        'Проверка State геттеров',
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
        'Проверка PageController',
        setupWM,
        (wm, tester, context) {
          tester.init();
          expect(wm.pageController, isNotNull);
        },
      );

      testWidgetModel<OnboardingWidgetModel, OnboardingScreen>(
        'Проверка навигации',
        setupWM,
        (wm, tester, context) {
          tester.init();
          wm.onSkipButton();
          // TODO(me): Проверить, что выполнилась навигация
          // verify
          wm.onStartButton();
          // TODO(me): Проверить, что выполнилась навигация
          // verify
        },
      );
    },
  );
}

class BuildContextMock extends Mock implements BuildContext {}

class OnboardingModelMock extends Mock implements OnboardingModel {}
