import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:places/assets/themes/app_theme.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_screen.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_wm.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';
import 'package:places/features/places_list/widgets/filter_settings_widgets/category_element_widget.dart';
import 'package:places/features/places_list/widgets/filter_settings_widgets/show_result_button.dart';

mixin DiagnosticableToStringMixin on Object {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return super.toString();
  }
}

class WMMock extends Mock
    with DiagnosticableToStringMixin
    implements FilterSettingsWidgetModel {}

final elementCount = PlaceType.values.length;
const initialRadius = 30.0;

final placeListMock = <Place>[
  Place(
    id: 1,
    lat: 55.0,
    lng: 55.0,
    name: 'name',
    urls: ['urls'],
    placeType: PlaceType.cafe,
    description: 'description',
  ),
  Place(
    id: 2,
    lat: 56.0,
    lng: 56.0,
    name: 'name2',
    urls: ['urls'],
    placeType: PlaceType.hotel,
    description: 'description',
  ),
  Place(
    id: 3,
    lat: 33.0,
    lng: 44.0,
    name: 'name3',
    urls: ['urls1'],
    placeType: PlaceType.park,
    description: 'description',
  ),
];

void main() {
  group('FilterScreen', () {
    late WMMock wmMock;

    setUp(() {
      wmMock = WMMock();

      when(() => wmMock.listPlaceState)
          .thenReturn(EntityStateNotifier.value(placeListMock));
      when(() => wmMock.sliderState)
          .thenReturn(StateNotifier(initValue: initialRadius));
      when(() => wmMock.filterState)
          .thenReturn(StateNotifier(initValue: PlaceType.values));
      when(() => wmMock.theme).thenReturn(ThemeData());
      when(() => wmMock.minSliderValue).thenReturn(10);
      when(() => wmMock.maxSliderValue).thenReturn(30);
    });

    void expectTick(WidgetTester tester, List<PlaceType> checkList) {
      final tickWidgetKeys = tester
          .widgetList<SelectTickWidget>(find.byType(SelectTickWidget))
          .map((widget) => widget.key);

      final placeTypeKeys = checkList.map((e) => ValueKey(e.name));

      for (final element in tickWidgetKeys) {
        expect(placeTypeKeys.contains(element), isTrue);
      }
    }

    testWidgets('Initial data', (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.lightTheme,
        home: FilterSettingsScreen(
          wmFactory: (_) => wmMock,
        ),
      ));

      expect(
        find.byType(CategoryElementWidget),
        findsNWidgets(elementCount),
      );

      expect(
        find.byType(SelectTickWidget),
        findsNWidgets(elementCount),
      );

      expectTick(tester, PlaceType.values);

      expect(
        find.text(
          '${PlacesListStrings.distanceTo} ${initialRadius.toStringAsFixed(2)} ${PlacesListStrings.distanceKm}',
        ),
        findsOneWidget,
      );

      expect(
        find.text(
          '${PlacesListStrings.showResult} (${placeListMock.length})',
        ),
        findsOneWidget,
      );

      final loadingButton = tester
          .widget<FloatingActionButton>(find.byType(FloatingActionButton));
      expect(loadingButton.onPressed, isNotNull);
    });

    testWidgets('Another data', (tester) async {
      const newRadius = 17.8;
      final newPlaceType = <PlaceType>[
        PlaceType.cafe,
        PlaceType.other,
        PlaceType.restaurant,
      ];
      final newPlaceListMock = <Place>[];

      when(() => wmMock.listPlaceState)
          .thenReturn(EntityStateNotifier.value(newPlaceListMock));
      when(() => wmMock.sliderState)
          .thenReturn(StateNotifier(initValue: newRadius));
      when(() => wmMock.filterState)
          .thenReturn(StateNotifier(initValue: newPlaceType));

      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.lightTheme,
        home: FilterSettingsScreen(
          wmFactory: (_) => wmMock,
        ),
      ));

      expect(
        find.byType(CategoryElementWidget),
        findsNWidgets(elementCount),
      );

      expect(
        find.byType(SelectTickWidget),
        findsNWidgets(newPlaceType.length),
      );

      expectTick(tester, newPlaceType);

      expect(
        find.text(
          '${PlacesListStrings.distanceTo} ${newRadius.toStringAsFixed(2)} ${PlacesListStrings.distanceKm}',
        ),
        findsOneWidget,
      );

      expect(
        find.text(
          '${PlacesListStrings.showResult} (${newPlaceListMock.length})',
        ),
        findsOneWidget,
      );

      final loadingButton = tester
          .widget<FloatingActionButton>(find.byType(FloatingActionButton));
      expect(loadingButton.onPressed, isNull);
    });

    testWidgets('Testing methods call', (tester) async {
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.lightTheme,
        home: FilterSettingsScreen(
          wmFactory: (_) => wmMock,
        ),
      ));

      // OnElementTap
      const testingType = PlaceType.hotel;

      final finderHotel = find.byKey(const ObjectKey(testingType));
      expect(finderHotel, findsOneWidget);

      final finderHotelTick = find.byKey(ValueKey(testingType.name));
      expect(finderHotelTick, findsOneWidget);

      final tickValue =
          tester.widget<CategoryElementWidget>(finderHotel).isSelect;
      expect(tickValue, isTrue);

      await tester.tap(finderHotel);

      verify(() => wmMock.onElementTap(tickValue, testingType));

      //OnClearTap
      final finderClearButton = find.byKey(const ValueKey('ClearButton'));
      expect(finderClearButton, findsOneWidget);

      await tester.tap(finderClearButton);
      verify(wmMock.onClearTap);

      //SliderChange
      final finderSlider = find.byType(Slider);

      final sliderValue = tester.widget<Slider>(finderSlider).value;
      expect(sliderValue, initialRadius);

      await tester.fling(finderSlider, const Offset(400, 0), 3000);

      verify(() => wmMock.onSliderChange(any()));

      //onBackButton
      final finderBackButton = find.byKey(const ValueKey('BackButton'));
      expect(finderBackButton, findsOneWidget);

      await tester.tap(finderBackButton);
      verify(wmMock.onBackButtonTap);

      //onShowResultButton
      final finderShowResultButton = find.byType(ShowResultButton);
      expect(finderShowResultButton, findsOneWidget);

      await tester.tap(finderShowResultButton);
      verify(wmMock.onShowResultTap);
    });
  });
}
