import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/navigation/app_router.dart';
import 'package:places/features/place_details/screen/place_details_model.dart';
import 'package:places/features/place_details/screen/place_details_screen.dart';
import 'package:places/features/place_details/widgets/date_picker_factory.dart';
import 'package:provider/provider.dart';

enum PlannedButtonState { disable, active, haveDate, share }

abstract class IPlaceDetailsWidgetModel extends IWidgetModel {
  ListenableState<PlannedButtonState> get plannedState;

  ListenableState<String?> get plannedDateState;

  ListenableState<bool> get favoriteState;

  ListenableState<double> get imageViewState;

  ListenableState<bool> get routeCompleteState;

  ListenableState<EntityState<bool>> get isLoadingProgressState;

  PageController get pageController;

  void onTapBackButton();

  void onTapFavorite();

  void onTapNavigation();

  Future<void> onTapPlanned();

  void onTapShare();
}

PlaceDetailsWidgetModel defaultPlaceDetailsWidgetModelFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();
  final model = PlaceDetailsModel(appScope.favoriteDbService);
  return PlaceDetailsWidgetModel(
    model: model,
    router: appScope.router,
  );
}

// TODO(me): cover with documentation
/// Default widget model for PlaceDetailsWidget
class PlaceDetailsWidgetModel
    extends WidgetModel<PlaceDetailsScreen, PlaceDetailsModel>
    implements IPlaceDetailsWidgetModel {
  final AppRouter _router;
  final StateNotifier<bool> _favoriteState = StateNotifier(initValue: false);
  final StateNotifier<double> _imageViewState = StateNotifier(initValue: 0.0);
  final StateNotifier<PlannedButtonState> _plannedState = StateNotifier(
    initValue: PlannedButtonState.disable,
  );
  final StateNotifier<String?> _plannedDateState = StateNotifier();
  final StateNotifier<bool> _routeCompleteState =
      StateNotifier(initValue: false);
  final _isLoadingProgressState = EntityStateNotifier<bool>.value(true);

  late final PageController _pageController;

  final _format = DateFormat('d MMM y', 'ru_RU');

  @override
  ListenableState<bool> get favoriteState => _favoriteState;

  @override
  ListenableState<double> get imageViewState => _imageViewState;

  @override
  PageController get pageController => _pageController;

  @override
  ListenableState<PlannedButtonState> get plannedState => _plannedState;

  @override
  ListenableState<String?> get plannedDateState => _plannedDateState;

  @override
  ListenableState<bool> get routeCompleteState => _routeCompleteState;

  @override
  ListenableState<EntityState<bool>> get isLoadingProgressState =>
      _isLoadingProgressState;

  DateTime? _plannedDate;
  PlannedButtonState? _prevState;
  bool _isFavoriteChange = false;

  PlaceDetailsWidgetModel({
    required PlaceDetailsModel model,
    required AppRouter router,
  })  : _router = router,
        super(model) {
    _loadingImitation();
    _init();
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    _initWM();
  }

  @override
  void onTapBackButton() {
    _router.pop<bool>(_isFavoriteChange);
  }

  @override
  void onTapFavorite() {
    _isFavoriteChange = !_isFavoriteChange;
    final prevValue = _favoriteState.value;

    if (prevValue!) {
      model.deleteFavorite(widget.place.id);
    } else {
      model.addFavorite(widget.place);
    }
    _favoriteState.accept(!prevValue);

    if (!_routeCompleteState.value!) {
      _plannedState.accept(
        prevValue ? PlannedButtonState.disable : PlannedButtonState.active,
      );
    }
  }

  @override
  void onTapNavigation() {
    // TODO(me): Для проверки логики UI
    final newValue = _routeCompleteState.value;
    if (newValue != null) {
      _routeCompleteState.accept(!newValue);
      if (!newValue) {
        _prevState = _plannedState.value;
        _plannedState.accept(PlannedButtonState.share);
      } else {
        _plannedState.accept(_prevState);
      }
    }
  }

  @override
  Future<void> onTapPlanned() async {
    await _selectDate();

    if (_plannedDate != null) {
      assert(_plannedDate != null, 'Planned date can not be null');
      _plannedDateState.accept(_format.format(_plannedDate!));
      unawaited(
        model.addFavorite(widget.place.copyWith(plannedDate: _plannedDate)),
      );

      if (_plannedState.value != PlannedButtonState.haveDate) {
        _plannedState.accept(PlannedButtonState.haveDate);
      }
    }
  }

  @override
  void onTapShare() {
    // TODO(me): implement onTapShare
  }

  Future<void> _init() async {
    _pageController = PageController()
      ..addListener(() {
        _imageViewState.accept(_pageController.page);
      });
  }

  Future<void> _initWM() async {
    final favoritePlaceOrNull =
        await model.checkPlaceIsFavorite(widget.place.id);
    if (favoritePlaceOrNull == null) {
      _favoriteState.accept(false);
    } else {
      _favoriteState.accept(true);

      if (favoritePlaceOrNull.plannedDate != null) {
        _plannedDate = favoritePlaceOrNull.plannedDate;

        _plannedDateState
            .accept(_format.format(favoritePlaceOrNull.plannedDate!));
        _plannedState.accept(PlannedButtonState.haveDate);
      } else {
        _plannedState.accept(PlannedButtonState.active);
      }
    }
  }

  Future<void> _selectDate() async {
    await datePickerFactory(
      context: context,
      initialDate: _plannedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2122),
      onDateTimeChanged: (newDate) => _plannedDate = newDate,
    );
  }

  Future<void> _loadingImitation() async {
    _isLoadingProgressState.loading();
    await Future<void>.delayed(const Duration(seconds: 3));
    _isLoadingProgressState.content(false);
  }
}
