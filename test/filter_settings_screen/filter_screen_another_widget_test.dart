import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:places/features/common/domain/entity/geoposition.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/common/service/geoposition_bloc/geoposition_bloc.dart';
import 'package:places/features/common/widgets/ui_func.dart';
import 'package:places/features/navigation/service/coordinator.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_model.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_screen.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_wm.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';
import 'package:places/features/places_list/widgets/filter_settings_widgets/category_element_widget.dart';

class CoordinatorMock extends Mock implements Coordinator {}

class MessageControllerMock extends Mock implements MessageController {}

class FilterSettingsModelMock extends Mock implements FilterSettingsModel {}

final elementCount = PlaceType.values.length;
const initialRadius = 30.0;

const geoState = GeopositionState.succsess(
  status: GeopositionStatus.ok,
  geoposition: Geoposition(latitude: 55.0, longitude: 55.0),
);

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
    late FilterSettingsModelMock modelMock;
    late CoordinatorMock coordinatorMock;
    late MessageControllerMock messageControllerMock;

    setUp(() {
      modelMock = FilterSettingsModelMock();
      coordinatorMock = CoordinatorMock();
      messageControllerMock = MessageControllerMock();

      when(() => modelMock.getFilterPlaceTypes())
          .thenAnswer((_) => Future.value(PlaceType.values));
      when(() => modelMock.getFilterDistance())
          .thenAnswer((_) => Future.value(initialRadius));
      when(() => modelMock.getFilteredPlacesList(
            lat: any(named: 'lat'),
            lng: any(named: 'lng'),
            radius: any(named: 'radius'),
            placeTypes: any(named: 'placeTypes'),
          )).thenAnswer((_) => Future.value(placeListMock));
      when(() => modelMock.geopositionState).thenReturn(geoState);
    });

    testWidgets('Init Screen', (tester) async {
      FloatingActionButton loadingButton;

      await tester.pumpWidget(MaterialApp(
        home: FilterSettingsScreen(
          wmFactory: (context) => FilterSettingsWidgetModel(
            model: modelMock,
            coordinator: coordinatorMock,
            messageController: messageControllerMock,
          ),
        ),
      ));

      await tester.pumpAndSettle();

      loadingButton = tester
          .widget<FloatingActionButton>(find.byType(FloatingActionButton));
      expect(loadingButton.onPressed, isNotNull);

      expect(
        find.byType(CategoryElementWidget),
        findsNWidgets(elementCount),
      );

      expect(
        find.byType(SelectTickWidget),
        findsNWidgets(elementCount),
      );

      final tickWidgetKeys = tester
          .widgetList<SelectTickWidget>(find.byType(SelectTickWidget))
          .map((widget) => widget.key);

      final placeTypeKeys = PlaceType.values.map((e) => ValueKey(e.name));

      for (final element in tickWidgetKeys) {
        expect(placeTypeKeys.contains(element), isTrue);
      }

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
    });

    testWidgets('Another filter settings', (tester) async {
      const newRadius = 17.8;
      final newPlaceType = <PlaceType>[
        PlaceType.cafe,
        PlaceType.other,
        PlaceType.restaurant,
      ];
      when(() => modelMock.getFilterPlaceTypes())
          .thenAnswer((_) => Future.value(newPlaceType));
      when(() => modelMock.getFilterDistance())
          .thenAnswer((_) => Future.value(newRadius));

      await tester.pumpWidget(MaterialApp(
        home: FilterSettingsScreen(
          wmFactory: (context) => FilterSettingsWidgetModel(
            model: modelMock,
            coordinator: coordinatorMock,
            messageController: messageControllerMock,
          ),
        ),
      ));

      await tester.pumpAndSettle();

      expect(
        find.byType(SelectTickWidget),
        findsNWidgets(newPlaceType.length),
      );

      final tickWidgetKeys = tester
          .widgetList<SelectTickWidget>(find.byType(SelectTickWidget))
          .map((widget) => widget.key);

      final placeTypeKeys = newPlaceType.map((e) => ValueKey(e.name));

      for (final element in tickWidgetKeys) {
        expect(placeTypeKeys.contains(element), isTrue);
      }

      expect(
        find.text(
          '${PlacesListStrings.distanceTo} ${newRadius.toStringAsFixed(2)} ${PlacesListStrings.distanceKm}',
        ),
        findsOneWidget,
      );
    });

    testWidgets('Change filter settings', (tester) async {
      const addingType = PlaceType.hotel;
      const oldRadius = 17.8;
      final oldPlaceType = <PlaceType>[
        PlaceType.cafe,
        PlaceType.other,
        PlaceType.restaurant,
      ];
      const newRadius = 30.0;
      final newPlaceType = <PlaceType>[
        PlaceType.cafe,
        PlaceType.other,
        PlaceType.restaurant,
        addingType,
      ];

      when(() => modelMock.getFilterPlaceTypes())
          .thenAnswer((_) => Future.value(oldPlaceType));
      when(() => modelMock.getFilterDistance())
          .thenAnswer((_) => Future.value(oldRadius));

      await tester.runAsync(() async {
        final wm = FilterSettingsWidgetModel(
          model: modelMock,
          coordinator: coordinatorMock,
          messageController: messageControllerMock,
        );

        await tester.pumpWidget(MaterialApp(
          home: FilterSettingsScreen(
            wmFactory: (context) => wm,
          ),
        ));

        await tester.pumpAndSettle();

        final elementTickHotel = find.byKey(ValueKey(addingType.name));

        expect(elementTickHotel, findsNothing);
        expect(
          find.text(
            '${PlacesListStrings.distanceTo} ${oldRadius.toStringAsFixed(2)} ${PlacesListStrings.distanceKm}',
          ),
          findsOneWidget,
        );

        final elementHotel = find.byKey(const ObjectKey(addingType));

        await tester.tap(elementHotel);
        await tester.fling(find.byType(Slider), const Offset(400, 0), 3000);

        final tickWidgetKeys = tester
            .widgetList<SelectTickWidget>(find.byType(SelectTickWidget))
            .map((widget) => widget.key);

        final placeTypeKeys = newPlaceType.map((e) => ValueKey(e.name));
        for (final element in tickWidgetKeys) {
          expect(placeTypeKeys.contains(element), isTrue);
        }

        final sliderValue = tester.widget<Slider>(find.byType(Slider)).value;
        expect(sliderValue, newRadius);

        expect(elementTickHotel, findsOneWidget);
        expect(
          find.text(
            '${PlacesListStrings.distanceTo} ${newRadius.toStringAsFixed(2)} ${PlacesListStrings.distanceKm}',
          ),
          findsOneWidget,
        );

        await Future<void>.delayed(const Duration(seconds: 2));

        verify(() => modelMock.getFilteredPlacesList(
              lat: any(named: 'lat'),
              lng: any(named: 'lng'),
              radius: newRadius,
              placeTypes: newPlaceType,
            ));
      });
    });
  });
}
