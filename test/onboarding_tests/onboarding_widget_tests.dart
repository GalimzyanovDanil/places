import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:places/features/onboarding/screen/onboarding_screen.dart';

Future<void> onboardingWidgetTest() async {
  group(
    'Виджет тесты - Онбординг',
    () {
      Future<void> _leftSwipe(WidgetTester tester) async {
        await tester.flingFrom(
          const Offset(750, 300),
          const Offset(-750, 0),
          2000,
        );
        await tester.pump();
      }

      testWidgets(
        'Кнопки - Старт и Пропустить',
        (tester) async {
          await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));

          final pageView = tester.widget<PageView>(find.byType(PageView));
          final childCount = pageView.childrenDelegate.estimatedChildCount;
          final pageCount = childCount ?? 0;

          final skipButton = find.byKey(const ValueKey('SkipButton'));
          final startButton = find.byKey(const ValueKey('StartButton'));

          void _expectOtherPage() {
            expect(skipButton, findsOneWidget);
            expect(startButton, findsNothing);
          }

          void _expectLastPage() {
            expect(skipButton, findsNothing);
            expect(startButton, findsOneWidget);
          }

          var i = 1;
          do {
            if (i != pageCount) {
              _expectOtherPage();
              await _leftSwipe(tester);
              i = i + 1;
            } else {
              _expectLastPage();
              break;
            }
          } while (i <= pageCount);
        },
      );
    },
  );
}
