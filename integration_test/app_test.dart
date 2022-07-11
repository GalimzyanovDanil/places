import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/onboarding/widgets/skip_button.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';
import 'package:places/features/places_list/widgets/filter_settings_widgets/category_element_widget.dart';
import 'package:places/features/places_list/widgets/filter_settings_widgets/show_result_button.dart';
import 'package:places/main_release.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  void expectTick(WidgetTester tester, List<PlaceType> checkList) {
    final tickWidgetKeys = tester
        .widgetList<SelectTickWidget>(find.byType(SelectTickWidget))
        .map((widget) => widget.key);
    if (checkList.isEmpty) {
      expect(tickWidgetKeys, isEmpty);
      return;
    }

    final placeTypeKeys = checkList.map((e) => ValueKey(e.name));

    for (final element in tickWidgetKeys) {
      expect(placeTypeKeys.contains(element), isTrue);
    }
  }

  testWidgets('app test', (tester) async {
    await tester.runAsync(() async {
      final sliderFinder = find.byType(Slider);
      final placeListFinder = find.byKey(const ValueKey('PlacesListScreen'));
      final filterFibder = find.byKey(const ValueKey('Filter'));

      app.main();

      await tester.pumpAndSettle();
      await Future<void>.delayed(const Duration(seconds: 2));
      await tester.tap(find.byType(SkipButton));
      await tester.pumpAndSettle();
      await Future<void>.delayed(const Duration(seconds: 5));
      // Проверка что экран списка загрузился
      expect(placeListFinder, findsOneWidget);

      // Проверка кнопки назад
      await tester.tap(filterFibder);
      await tester.pumpAndSettle();
      // Проверка, что экран фильтра загргузился
      expect(
        find.byKey(const ValueKey('FilterSettingsScreen')),
        findsOneWidget,
      );

      await tester.tap(find.byKey(const ValueKey('BackButton')));
      await tester.pumpAndSettle();
      expect(placeListFinder, findsOneWidget);

      await tester.tap(filterFibder);
      await tester.pumpAndSettle();
      await Future<void>.delayed(const Duration(seconds: 5));

      // ... что все фильтры выбраны, т.к. это значение по умолчанию
      expectTick(tester, PlaceType.values);
      // ... что значение радиуса 30, т.к. это значение по умолчанию
      var sliderValue = tester.widget<Slider>(sliderFinder).value;
      expect(sliderValue, 30.0);
      await tester.tap(find.byKey(const ObjectKey(PlaceType.museum)));
      await tester.pumpAndSettle();
      await Future<void>.delayed(const Duration(seconds: 2));
      // Проверка, что снялся выбор с элемента "Музей"
      final newTickList = List.of(PlaceType.values)..remove(PlaceType.museum);
      expectTick(tester, newTickList);
      await tester.fling(sliderFinder, const Offset(-400, 0), 1000);
      await tester.pumpAndSettle();
      await Future<void>.delayed(const Duration(seconds: 2));
      // Проверка, что радиус изменился на 10
      sliderValue = tester.widget<Slider>(sliderFinder).value;
      expect(sliderValue, 10.0);
      await tester.fling(find.byType(Slider), const Offset(400, 0), 1000);
      await Future<void>.delayed(const Duration(seconds: 2));
      await tester.tap(find.byKey(const ObjectKey(PlaceType.park)));
      await Future<void>.delayed(const Duration(seconds: 2));
      await tester.pumpAndSettle();
      await Future<void>.delayed(const Duration(seconds: 2));

      // Проверка, что снялся парк и радиус 30
      expectTick(tester, newTickList..remove(PlaceType.park));
      sliderValue = tester.widget<Slider>(sliderFinder).value;
      expect(sliderValue, 30.0);
      // Нажатие на кнопку Очистить
      await tester.tap(find.byKey(const ValueKey('ClearButton')));
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await Future<void>.delayed(const Duration(seconds: 5));
      // Проверка, что ни один элемент не выбран и фильтр равен 10
      expectTick(tester, []);
      sliderValue = tester.widget<Slider>(sliderFinder).value;
      expect(sliderValue, 10.0);
      // Проверка, что поиск выдал значение 0 и нет возможности на него тапнуть
      final resultButton = tester
          .widget<FloatingActionButton>(find.byType(FloatingActionButton));
      expect(resultButton.onPressed, isNull);
      expect(find.text('${PlacesListStrings.showResult} (0)'), findsOneWidget);

      // Выбрать несколько элементов и запомнить количество найденных
      await tester.tap(find.byKey(const ObjectKey(PlaceType.park)));
      await tester.tap(find.byKey(const ObjectKey(PlaceType.other)));
      await tester.pumpAndSettle(const Duration(seconds: 3));
      await Future<void>.delayed(const Duration(seconds: 5));

      final showresultFinder = find.byType(ShowResultButton);
      final findPlacesCount =
          tester.widget<ShowResultButton>(showresultFinder).countFindElements;
      expect(findPlacesCount, isNotNull);
      expect(
        find.text('${PlacesListStrings.showResult} ($findPlacesCount)'),
        findsOneWidget,
      );

      // Нажать на кнопку показать
      await tester.tap(showresultFinder);
      await tester.pumpAndSettle();
      await Future<void>.delayed(const Duration(seconds: 2));

      // Проверка что экран списка загрузился
      expect(placeListFinder, findsOneWidget);

      // Сверить количество найденных с количеством отображаемых
      for (var i = 0; i <= findPlacesCount!; i++) {
        await tester.fling(placeListFinder, const Offset(0, -200), 2000);
        await tester.pumpAndSettle();
      }
      final index = findPlacesCount - 1;
      expect(find.byKey(ValueKey(index)), findsOneWidget);
      expect(find.byKey(ValueKey(index + 1)), findsNothing);
    });
  });
}
