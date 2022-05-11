import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:places/features/onboarding/screen/onboarding_screen.dart';

void main() {
  Future<void> _leftSwipe(WidgetTester tester) async {
    await tester.flingFrom(const Offset(750, 300), const Offset(-750, 0), 1000);
    await tester.pump();
  }

  testWidgets(
    'Buttons',
    (tester) async {
      // Можно ли как то достать здесь количество страниц либо из WM,
      // либо что то типо PageView.children.lenght ?
      const pageCount = 3;
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

      await tester.pumpWidget(const MaterialApp(home: OnboardingScreen()));
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
}
