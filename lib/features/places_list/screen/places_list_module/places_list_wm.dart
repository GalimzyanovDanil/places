import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/common/app_exceptions/api_exception.dart';
import 'package:places/features/common/domain/entity/geoposition.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/common/service/geoposition_bloc/geoposition_bloc.dart';
import 'package:places/features/common/strings/dialog_strings.dart';
import 'package:places/features/common/widgets/ui_func.dart';
import 'package:places/features/common/widgets/widgets_factory.dart';
import 'package:places/features/navigation/app_router.dart';
import 'package:places/features/places_list/screen/places_list_module/places_list_model.dart';
import 'package:places/features/places_list/screen/places_list_module/places_list_screen.dart';
import 'package:provider/provider.dart';

abstract class IPlacesListWidgetModel extends IWidgetModel {
  PagingController<int, Place> get pagingController;
  ThemeData get theme;
  Animation<Offset> get animation;
  void onTapCard(int index);
  Future<void> onRefresh();
  void onSearchBarTap();
  Future<void> onSettingsTap();
  void onAddPlaceTap();
}

PlacesListWidgetModel defaultPlacesListWidgetModelFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();

  final model = PlacesListModel(
    errorHandler: appScope.errorHandler,
    placesService: appScope.placesService,
    connectivityResult: appScope.connectivityResult,
    geopositionBloc: appScope.geopositionBloc,
    appSettingsService: appScope.appSettingsService,
  );

  return PlacesListWidgetModel(
    model: model,
    router: appScope.router,
    messageController: appScope.messageController,
  );
}

// TODO(me): cover with documentation
/// Default widget model for PlacesListWidget
class PlacesListWidgetModel
    extends WidgetModel<PlacesListScreen, PlacesListModel>
    with TickerProviderWidgetModelMixin
    implements IPlacesListWidgetModel {
  /// Отступ от начального элемента базы
  final int currentOffset = 0;

  /// Количество загружаемых мест
  final placeCount = 15;
  final MessageController messageController;
  final AppRouter _router;

  late final PagingController<int, Place> _pagingController;
  late final AnimationController _animationController;
  late final Animation<Offset> _animation;

  @override
  PagingController<int, Place> get pagingController => _pagingController;

  @override
  ThemeData get theme => Theme.of(context);

  @override
  Animation<Offset> get animation => _animation;

  Geoposition? _currentGeoposition;
  List<String>? _filteredPlaceType;
  double? _radius;

  /// Триггер последней страницы загрузки
  bool _isLastPage = false;

  PlacesListWidgetModel({
    required PlacesListModel model,
    required AppRouter router,
    required this.messageController,
  })  : _router = router,
        super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _init();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = Tween<Offset>(
      begin: const Offset(-2, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Future<void> onTapCard(int index) async {
    final currentPlace = _pagingController.itemList?[index];

    if (currentPlace != null) {
      final place = currentPlace;
      final isNeedUpdate =
          await _router.push<bool>(PlaceDetailsPageRoute(place: place));
      if (isNeedUpdate ?? false) pagingController.refresh();
    }
  }

  @override
  Future<void> onRefresh() async {
    pagingController.refresh();
  }

  @override
  void onSearchBarTap() {
    _router
        .pushNamed(RoutesStrings.search)
        .whenComplete(() => pagingController.refresh());
  }

  @override
  Future<void> onSettingsTap() async {
    await _geopositionChecks().then((isEnabled) async {
      if (isEnabled) {
        final isNeedUpdate =
            await _router.pushNamed<bool>(RoutesStrings.filterSettings);
        if (isNeedUpdate ?? false) pagingController.refresh();
      }
    });
  }

  @override
  void onAddPlaceTap() {
    _router
        .pushNamed(RoutesStrings.addPlace)
        .whenComplete(() => pagingController.refresh());
  }

  // Инициализация
  Future<void> _init() async {
    _pagingController =
        PagingController<int, Place>(firstPageKey: currentOffset)
          ..addPageRequestListener(_getPlacesList);
  }

  // Получение списка мест
  Future<void> _getPlacesList(int offset) async {
    try {
      final isAllPlaces = await _loadAllDeterminate();

      if (isAllPlaces) {
        await _getAllPlacesList(offset);
      } else {
        await _getFilteredPlaces(
          lat: _currentGeoposition!.latitude,
          lng: _currentGeoposition!.longitude,
          radius: _radius!,
          placeTypes: _filteredPlaceType!.map(PlaceType.fromString).toList(),
        );
      }
    } on ApiException catch (error) {
      _pagingController.error = error;
    }
  }

  Future<bool> _loadAllDeterminate() async {
    _currentGeoposition = model.geopositionState.whenOrNull<Geoposition?>(
      succsess: (_, geoposition) => geoposition,
    );
    if (_currentGeoposition == null) return true;
    _filteredPlaceType = await model.getFilterPlaceType();
    _radius = await model.getFilterDistance();
    return false;
  }

  Future<void> _getFilteredPlaces({
    required double lat,
    required double lng,
    required double radius,
    required List<PlaceType> placeTypes,
  }) async {
    // TODO(me): Удалить после проверки
    await Future<void>.delayed(const Duration(seconds: 2));
    await model
        .getFilteredPlacesList(
      lat: lat,
      lng: lng,
      radius: radius,
      placeTypes: placeTypes,
    )
        .then((content) {
      content.sort((a, b) {
        assert(a.distance != null && b.distance != null,
            'Incorrect data from server');
        return a.distance!.compareTo(b.distance!);
      });
      _pagingController.appendLastPage(content);
    });
  }

  Future<void> _getAllPlacesList(int offset) async {
    await model.getPlacesList(placeCount, offset).then(
      (content) async {
        // TODO(me): Удалить после проверки
        await Future<void>.delayed(const Duration(seconds: 2));
        for (final element in content) {
          _correctImageUrls(element.urls);
        }
        _isLastPage = content.length < placeCount;

        if (isMounted) {
          if (_isLastPage) {
            _pagingController.appendLastPage(content);
          } else {
            final nextPageKey = offset + placeCount;
            _pagingController.appendPage(content, nextPageKey);
          }
        }
      },
    );
  }

  // Удаление URL, не являющихся ссылками на изображения
  void _correctImageUrls(List<String> list) {
    const checkList = ['.jpg', '.jpeg', '.png', '.svg'];

    list.retainWhere((element) {
      var isOk = false;
      for (var i = 0; i < checkList.length; i++) {
        isOk = element.endsWith(checkList[i]);
        if (isOk) break;
      }
      return isOk;
    });
  }

  Future<bool> _geopositionChecks() async {
    return model.geopositionState.map<bool>(
      initial: (_) => false,
      getStatusInProgress: (_) => false,
      getPositionInProgress: (_) => true,
      succsess: (_) => true,
      error: (state) {
        if (state.status == GeopositionStatus.deniedForever) {
          messageController.showSnackBar(
            text: DialogStrings.geoPermissinoSnackBarText,
            context: context,
          );
          return false;
        }
        _showMyDialog(
          alertDialogWidget: WidgetsFactory.alertDialogWidgetFactory(
            title: DialogStrings.errorTitle,
            onConfirm: () async {
              model.requsetAndIsCheckPermission();
            },
            bodyText: DialogStrings.requetBodyText,
            confirmTitle: DialogStrings.confirmText,
            declineTitle: DialogStrings.declineText,
          ),
        );
        return false;
      },
    );
  }

  Future<void> _showMyDialog({required Widget alertDialogWidget}) async {
    if (isMounted) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return alertDialogWidget;
        },
      );
    }
  }
}
