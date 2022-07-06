// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:places/features/navigation/service/coordinator.dart';
import 'package:places/features/onboarding/screen/onboarding_model.dart';
import 'package:places/features/onboarding/screen/onboarding_screen.dart';
import 'package:places/features/onboarding/screen/onboarding_wm.dart';

class CoordinatorMock extends Mock implements Coordinator {}

class OnboardingModelMock extends Mock implements OnboardingModel {}

void main() async {
  group(
    'Виджет тесты - Онбординг',
    () {
      late Coordinator coordinatorMock;
      late OnboardingModel onboardingModelMock;

      setUp(() {
        coordinatorMock = CoordinatorMock();
        onboardingModelMock = OnboardingModelMock();
      });

      Future<void> _leftSwipe(WidgetTester tester) async {
        await tester.flingFrom(
          const Offset(750, 300),
          const Offset(-750, 0),
          2000,
        );
      }

      testWidgets(
        'Кнопки - Старт и Пропустить',
        (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: OnboardingScreen(
                wmFactory: (context) => OnboardingWidgetModel(
                  coordinator: coordinatorMock,
                  model: onboardingModelMock,
                ),
              ),
            ),
          );

          final pageView = tester.widget<PageView>(find.byType(PageView));
          final childCount = pageView.childrenDelegate.estimatedChildCount;
          final pageCount = childCount ?? 0;
          var opacity = 1.0;
          var offset = Offset.zero;

          var i = 1;
          do {
            if (i != pageCount) {
              final skipButton =
                  tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity));
              opacity = skipButton.opacity;
              final startButton =
                  tester.widget<AnimatedSlide>(find.byType(AnimatedSlide));
              offset = startButton.offset;

              expect(opacity, 1.0);
              expect(offset, const Offset(0, 2));
              await _leftSwipe(tester);
              await tester.pumpAndSettle();

              i = i + 1;
            } else {
              final skipButton =
                  tester.widget<AnimatedOpacity>(find.byType(AnimatedOpacity));
              opacity = skipButton.opacity;
              final startButton =
                  tester.widget<AnimatedSlide>(find.byType(AnimatedSlide));
              offset = startButton.offset;

              expect(opacity, 0.0);
              expect(offset, Offset.zero);
              break;
            }
          } while (i <= pageCount);
        },
      );
    },
  );
}
