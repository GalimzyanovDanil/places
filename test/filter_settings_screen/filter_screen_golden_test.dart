import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:places/assets/themes/app_theme.dart';
import 'package:places/features/common/domain/entity/geoposition.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/domain/entity/place_filter.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/common/service/app_settings_service.dart';
import 'package:places/features/common/service/geoposition_bloc/geoposition_bloc.dart';
import 'package:places/features/common/service/places_service.dart';
import 'package:places/features/common/widgets/ui_func.dart';
import 'package:places/features/navigation/service/coordinator.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_model.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_screen.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_wm.dart';

class CoordinatorMock extends Mock implements Coordinator {}

class MessageControllerMock extends Mock implements MessageController {}

class AppSettingsServiceMock extends Mock implements AppSettingsService {}

class PlacesServiceMock extends Mock implements PlacesService {}

class ErrorHandlerMock extends Mock implements ErrorHandler {}

class GeopositionBlocMock extends Mock implements GeopositionBloc {}

class PlaceFilterFake extends Fake implements PlaceFilter {}

final mockPlaceType = <PlaceType>[
  PlaceType.hotel,
  PlaceType.restaurant,
  PlaceType.other,
  PlaceType.cafe,
];

const initialRadius = 30.0;
const initialLat = 55.0;
const initialLng = 75.0;

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

const geopositionStateOk = GeopositionState.succsess(
  status: GeopositionStatus.ok,
  geoposition: Geoposition(latitude: initialLat, longitude: initialLng),
);

void main() {
  group('FilterScreenGolden', () {
    late AppSettingsService appSettingsServiceMock;
    late PlacesService placesServiceMock;
    late ErrorHandler errorHandlerMock;
    late GeopositionBloc geopositionBlocMock;
    late Coordinator coordinatorMock;
    late MessageController messageControllerMock;

    setUpAll(() {
      registerFallbackValue(PlaceFilterFake());
    });

    setUp(() {
      appSettingsServiceMock = AppSettingsServiceMock();
      placesServiceMock = PlacesServiceMock();
      errorHandlerMock = ErrorHandlerMock();
      geopositionBlocMock = GeopositionBlocMock();
      coordinatorMock = CoordinatorMock();
      messageControllerMock = MessageControllerMock();

      when(() => appSettingsServiceMock.getFilterPlaceTypes())
          .thenAnswer((_) => Future.value(
                PlaceType.values.map((e) => e.name).toList(),
              ));
      when(() => appSettingsServiceMock.getFilterDistance())
          .thenAnswer((_) => Future.value(initialRadius));
      when(() => placesServiceMock.getFilteredPlace(any()))
          .thenAnswer((_) => Future.value(placeListMock));

      when(() => geopositionBlocMock.state).thenReturn(geopositionStateOk);
    });

    Future<void> pumpScreen(WidgetTester tester) async =>
        tester.pumpWidgetBuilder(
          FilterSettingsScreen(
            wmFactory: (_) => FilterSettingsWidgetModel(
              coordinator: coordinatorMock,
              messageController: messageControllerMock,
              model: FilterSettingsModel(
                appSettingsService: appSettingsServiceMock,
                connectivityResult: ConnectivityResult.mobile,
                errorHandler: errorHandlerMock,
                geopositionBloc: geopositionBlocMock,
                placesService: placesServiceMock,
              ),
            ),
          ),
          wrapper: materialAppWrapper(
            theme: AppTheme.lightTheme,
          ),
        );

    testGoldens(
      'FilterScreenGolden initial',
      (tester) async {
        await pumpScreen(tester);
        await multiScreenGolden(tester, 'initial');
      },
    );

    testGoldens(
      'FilterScreen Golden change type',
      (tester) async {
        when(() => appSettingsServiceMock.getFilterPlaceTypes())
            .thenAnswer((_) => Future.value(
                  mockPlaceType.map((e) => e.name).toList(),
                ));

        await pumpScreen(tester);
        await multiScreenGolden(tester, 'change_type');
      },
    );

    testGoldens(
      'FilterScreen Golden change radius',
      (tester) async {
        when(() => appSettingsServiceMock.getFilterDistance())
            .thenAnswer((_) => Future.value(24.967894));
        await pumpScreen(tester);
        await multiScreenGolden(tester, 'change_radius');
      },
    );

    testGoldens(
      'FilterScreen Golden change place list',
      (tester) async {
        when(() => placesServiceMock.getFilteredPlace(any()))
            .thenAnswer((_) => Future.value([]));
        await pumpScreen(tester);
        await multiScreenGolden(tester, 'change_place_list');
      },
    );

    testGoldens(
      'FilterScreen Golden change all',
      (tester) async {
        when(() => appSettingsServiceMock.getFilterPlaceTypes())
            .thenAnswer((_) => Future.value(
                  List.of(mockPlaceType..removeLast())
                      .map((e) => e.name)
                      .toList(),
                ));
        when(() => appSettingsServiceMock.getFilterDistance())
            .thenAnswer((_) => Future.value(19.09894));
        when(() => placesServiceMock.getFilteredPlace(any()))
            .thenAnswer((_) => Future.value([]));
        await pumpScreen(tester);
        await multiScreenGolden(tester, 'change_all');
      },
    );
  });
}
