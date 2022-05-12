import 'onboarding_tests/onboarding_widget_tests.dart';
import 'onboarding_tests/onboarding_wm_tests.dart';

Future<void> main() async {
  // Тесты фичи - Онбординг
  await onboardingWidgetTest();
  await onboardingWidgetModelTest();
}
