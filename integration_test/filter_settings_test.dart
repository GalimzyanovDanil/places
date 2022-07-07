import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:places/assets/res/app_assets.dart';
import 'package:places/assets/themes/app_theme.dart';
import 'package:places/features/common/domain/entity/geoposition.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/common/service/geoposition_bloc/geoposition_bloc.dart';
import 'package:places/features/common/widgets/ui_func.dart';
import 'package:places/features/navigation/service/coordinator.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_model.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_screen.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_wm.dart';
import 'package:places/features/places_list/widgets/filter_settings_widgets/category_element_widget.dart';

class CoordinatorMock extends Mock implements Coordinator {}

class MessageControllerMock extends Mock implements MessageController {}

class FilterSettingsModelMock extends Mock implements FilterSettingsModel {}

final elementCount = PlaceType.values.length;
const initialRadius = 10.0;

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

final iconsCache = [
  precachePicture(
    ExactAssetPicture(
      SvgPicture.svgStringDecoderBuilder,
      AppAssets.iconTick,
    ),
    null,
  ),
  precachePicture(
    ExactAssetPicture(
      SvgPicture.svgStringDecoderBuilder,
      AppAssets.iconMuseum,
    ),
    null,
  ),
  precachePicture(
    ExactAssetPicture(
      SvgPicture.svgStringDecoderBuilder,
      AppAssets.iconHotel,
    ),
    null,
  ),
  precachePicture(
    ExactAssetPicture(
      SvgPicture.svgStringDecoderBuilder,
      AppAssets.iconRestourant,
    ),
    null,
  ),
  precachePicture(
    ExactAssetPicture(
      SvgPicture.svgStringDecoderBuilder,
      AppAssets.iconParticularPlace,
    ),
    null,
  ),
  precachePicture(
    ExactAssetPicture(
      SvgPicture.svgStringDecoderBuilder,
      AppAssets.iconPark,
    ),
    null,
  ),
  precachePicture(
    ExactAssetPicture(
      SvgPicture.svgStringDecoderBuilder,
      AppAssets.iconCafe,
    ),
    null,
  ),
  precachePicture(
    ExactAssetPicture(
      SvgPicture.svgStringDecoderBuilder,
      AppAssets.iconArrow,
    ),
    null,
  ),
  precachePicture(
    ExactAssetPicture(
      SvgPicture.svgStringDecoderBuilder,
      AppAssets.iconSplashLogo,
    ),
    null,
  ),
];

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

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Integration', () {
    final modelMock = FilterSettingsModelMock();
    final coordinatorMock = CoordinatorMock();
    final messageControllerMock = MessageControllerMock();

    setUp(() {
      when(modelMock.getFilterPlaceTypes)
          .thenAnswer((_) => Future.value(PlaceType.values));
      when(modelMock.getFilterDistance)
          .thenAnswer((_) => Future.value(initialRadius));
      when(() => modelMock.getFilteredPlacesList(
            lat: any(named: 'lat'),
            lng: any(named: 'lng'),
            radius: any(named: 'radius'),
            placeTypes: any(named: 'placeTypes'),
          )).thenAnswer((_) => Future.value(placeListMock));
      when(() => modelMock.geopositionState).thenReturn(geoState);
    });

    testWidgets('Filter Settings', (tester) async {
      await Future.wait(iconsCache);

      await Future<void>.delayed(const Duration(seconds: 2));

      runApp(MaterialApp(
        theme: AppTheme.lightTheme,
        home: FilterSettingsScreen(
          wmFactory: (_) => FilterSettingsWidgetModel(
            model: modelMock,
            coordinator: coordinatorMock,
            messageController: messageControllerMock,
          ),
        ),
      ));

      await tester.pumpAndSettle(const Duration(seconds: 5));

      expectTick(tester, PlaceType.values);

      // Нажатие по типу фильтра
      const addingType = PlaceType.hotel;
      final elementHotel = find.byKey(const ObjectKey(addingType));
      await tester.tap(elementHotel);
      await tester.pumpAndSettle(const Duration(seconds: 3));
      final newList = List.of(PlaceType.values)..remove(addingType);
      expectTick(tester, newList);
      // Изменение значения радиуса поиска
      final sliderFinder = find.byType(Slider);
      await tester.fling(sliderFinder, const Offset(400, 0), 3000);
      await tester.pumpAndSettle(const Duration(seconds: 3));
      final sliderValue = tester.widget<Slider>(sliderFinder).value;
      expect(sliderValue, 30.0);

      // Очистка всех значений
      final finderClearButton = find.byKey(const ValueKey('ClearButton'));
      await tester.tap(finderClearButton);
      await tester.pumpAndSettle(const Duration(seconds: 3));
      expectTick(tester, []);
      final sliderValueNew = tester.widget<Slider>(sliderFinder).value;
      expect(sliderValueNew, 10.0);
    });
  });
}
