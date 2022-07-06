import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_test/elementary_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:places/features/common/app_exceptions/exception_strings.dart';
import 'package:places/features/common/domain/entity/geoposition.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/domain/entity/place_filter.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/common/service/app_settings_service.dart';
import 'package:places/features/common/service/geoposition_bloc/geoposition_bloc.dart';
import 'package:places/features/common/service/places_service.dart';
import 'package:places/features/common/strings/dialog_strings.dart';
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

final allPlaceType = <PlaceType>[
  PlaceType.hotel,
  PlaceType.restaurant,
  PlaceType.other,
  PlaceType.park,
  PlaceType.museum,
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
  group('SettingsScreenWM', () {
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
                allPlaceType.map((e) => e.name).toList(),
              ));
      when(() => appSettingsServiceMock.getFilterDistance())
          .thenAnswer((_) => Future.value(initialRadius));
      when(() => placesServiceMock.getFilteredPlace(any()))
          .thenAnswer((_) => Future.value(placeListMock));

      when(() => geopositionBlocMock.state).thenReturn(geopositionStateOk);
    });

    FilterSettingsWidgetModel setupWm(ConnectivityResult connectivityResult) =>
        FilterSettingsWidgetModel(
          coordinator: coordinatorMock,
          messageController: messageControllerMock,
          model: FilterSettingsModel(
            appSettingsService: appSettingsServiceMock,
            connectivityResult: connectivityResult,
            errorHandler: errorHandlerMock,
            geopositionBloc: geopositionBlocMock,
            placesService: placesServiceMock,
          ),
        );

    testWidgetModel<FilterSettingsWidgetModel, FilterSettingsScreen>(
      'InitWM',
      () => setupWm(ConnectivityResult.mobile),
      (wm, tester, context) async {
        tester.init();

        await Future<void>.delayed(Duration.zero);

        verify(() => appSettingsServiceMock.getFilterPlaceTypes());
        verify(() => appSettingsServiceMock.getFilterDistance());

        expect(wm.filterState.value, allPlaceType);
        expect(wm.sliderState.value, initialRadius);

        final capture =
            verify(() => placesServiceMock.getFilteredPlace(captureAny()))
                .captured
                .last as PlaceFilter;

        expect(capture.lat, initialLat);
        expect(capture.lng, initialLng);
        //Проверка идет в метрах
        expect(capture.radius, initialRadius * 1000);
        expect(capture.typeFilter, allPlaceType);

        expect(wm.listPlaceState.value?.data, placeListMock);
      },
    );

    testWidgetModel<FilterSettingsWidgetModel, FilterSettingsScreen>(
      'SliderChange',
      () => setupWm(ConnectivityResult.mobile),
      (wm, tester, context) async {
        const setValue = 25.0;

        tester.init();

        await Future<void>.delayed(Duration.zero);

        wm.onSliderChange(setValue);

        expect(wm.sliderState.value, setValue);

        clearInteractions(placesServiceMock);
        verifyNever(() => placesServiceMock.getFilteredPlace(any()));

        await Future<void>.delayed(const Duration(seconds: 2));

        final capture =
            verify(() => placesServiceMock.getFilteredPlace(captureAny()))
                .captured
                .last as PlaceFilter;

        expect(capture.radius, setValue * 1000);

        expect(wm.listPlaceState.value?.data, placeListMock);
      },
    );

    testWidgetModel<FilterSettingsWidgetModel, FilterSettingsScreen>(
      'OnBackButtonTap',
      () => setupWm(ConnectivityResult.mobile),
      (wm, tester, context) async {
        tester.init();

        await Future<void>.delayed(Duration.zero);

        wm.onBackButtonTap();

        verify(() => coordinatorMock.pop(context));
      },
    );

    testWidgetModel<FilterSettingsWidgetModel, FilterSettingsScreen>(
      'onClearTap',
      () => setupWm(ConnectivityResult.mobile),
      (wm, tester, context) async {
        const clearRadius = 10.0;
        const emptyPlaceTypes = <PlaceType>[];

        tester.init();

        await Future<void>.delayed(Duration.zero);

        when(() => placesServiceMock.getFilteredPlace(any()))
            .thenAnswer((_) => Future.value([]));

        wm.onClearTap();

        expect(wm.sliderState.value, clearRadius);
        expect(wm.filterState.value, emptyPlaceTypes);

        clearInteractions(placesServiceMock);
        verifyNever(() => placesServiceMock.getFilteredPlace(any()));

        await Future<void>.delayed(const Duration(seconds: 2));

        final capture =
            verify(() => placesServiceMock.getFilteredPlace(captureAny()))
                .captured
                .last as PlaceFilter;

        expect(capture.radius, clearRadius * 1000);
        expect(capture.typeFilter, emptyPlaceTypes);
        expect(wm.listPlaceState.value?.data, <Place>[]);
      },
    );

    testWidgetModel<FilterSettingsWidgetModel, FilterSettingsScreen>(
      'onShowResult',
      () => setupWm(ConnectivityResult.mobile),
      (wm, tester, context) async {
        tester.init();

        await Future<void>.delayed(Duration.zero);

        when(() => appSettingsServiceMock.setFilterPlaceTypes(any()))
            .thenAnswer((_) => Future.value());
        when(() => appSettingsServiceMock.setFilterDistance(any()))
            .thenAnswer((_) => Future.value());

        wm.onShowResultTap();

        await Future<void>.delayed(Duration.zero);

        final capturePlaceTypes = verify(
          () => appSettingsServiceMock.setFilterPlaceTypes(captureAny()),
        ).captured.last as List<String>;

        expect(capturePlaceTypes, allPlaceType.map((e) => e.name));

        final captureFilterRadius =
            verify(() => appSettingsServiceMock.setFilterDistance(captureAny()))
                .captured
                .last as double;

        expect(captureFilterRadius, initialRadius);

        verify(() => coordinatorMock.pop(context, forceRebuild: true));
      },
    );

    testWidgetModel<FilterSettingsWidgetModel, FilterSettingsScreen>(
      'onElementTap',
      () => setupWm(ConnectivityResult.mobile),
      (wm, tester, context) async {
        tester.init();

        await Future<void>.delayed(Duration.zero);

        expect(wm.filterState.value, allPlaceType);

        const type = PlaceType.cafe;
        var isSel = wm.filterState.value!.contains(type);
        wm.onElementTap(isSel, type);

        clearInteractions(placesServiceMock);
        verifyNever(() => placesServiceMock.getFilteredPlace(any()));

        final newList = allPlaceType.toList()..remove(type);

        expect(wm.filterState.value, newList);

        await Future<void>.delayed(const Duration(seconds: 2));

        var capture =
            verify(() => placesServiceMock.getFilteredPlace(captureAny()))
                .captured
                .last as PlaceFilter;
        expect(capture.typeFilter, newList);

        isSel = wm.filterState.value!.contains(type);
        wm.onElementTap(isSel, type);

        expect(wm.filterState.value, allPlaceType);

        await Future<void>.delayed(const Duration(seconds: 2));

        capture = verify(() => placesServiceMock.getFilteredPlace(captureAny()))
            .captured
            .last as PlaceFilter;
        expect(capture.typeFilter, allPlaceType);
      },
    );

    testWidgetModel<FilterSettingsWidgetModel, FilterSettingsScreen>(
      'NetworkExceptionTest',
      () => setupWm(ConnectivityResult.none),
      (wm, tester, context) async {
        final exception = Exception('Mock');
        when(() => placesServiceMock.getFilteredPlace(any()))
            .thenThrow(exception);

        when(() => messageControllerMock.showSnackBar(
              text: any(named: 'text'),
              context: context,
            )).thenAnswer((_) => Future.value());

        tester.init();

        await Future<void>.delayed(Duration.zero);

        verify(() => messageControllerMock.showSnackBar(
              context: context,
              text: DialogStrings.networkErrorSnackBarText,
            ));

        verify(() => errorHandlerMock.handleError(exception));
        verify(() =>
            errorHandlerMock.handleError(ExceptionStrings.networkException));
      },
    );

    testWidgetModel<FilterSettingsWidgetModel, FilterSettingsScreen>(
      'OtherApiExceptionTest',
      () => setupWm(ConnectivityResult.mobile),
      (wm, tester, context) async {
        final exception = Exception('Mock');
        when(() => placesServiceMock.getFilteredPlace(any()))
            .thenThrow(exception);

        when(() => messageControllerMock.showSnackBar(
              text: any(named: 'text'),
              context: context,
            )).thenAnswer((_) => Future.value());

        tester.init();

        await Future<void>.delayed(Duration.zero);

        verify(() => messageControllerMock.showSnackBar(
              context: context,
              text: DialogStrings.otherErrorSnackBarText,
            ));

        verify(() => errorHandlerMock.handleError(exception));
        verify(() =>
            errorHandlerMock.handleError(ExceptionStrings.otherApiException));
      },
    );
  });
}
