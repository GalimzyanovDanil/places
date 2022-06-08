import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/navigation/service/coordinator.dart';
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
  PageController get pageController;
  void onTapBackButton();
  void onTapFavorite();
  void onTapNavigation();
  Future<void> onTapPlanned();
  void onTapShare();
}

PlaceDetailsWidgetModel defaultPlaceDetailsWidgetModelFactory(
    BuildContext context) {
  final appScope = context.read<IAppScope>();
  final model = PlaceDetailsModel(appScope.errorHandler);
  return PlaceDetailsWidgetModel(
    model: model,
    coordinator: appScope.coordinator,
  );
}

// TODO: cover with documentation
/// Default widget model for PlaceDetailsWidget
class PlaceDetailsWidgetModel
    extends WidgetModel<PlaceDetailsScreen, PlaceDetailsModel>
    implements IPlaceDetailsWidgetModel {
  PlaceDetailsWidgetModel(
      {required PlaceDetailsModel model, required Coordinator coordinator})
      : _coordinator = coordinator,
        super(model) {
    _init();
  }

  final Coordinator _coordinator;
  final StateNotifier<bool> _favoriteState = StateNotifier(initValue: false);
  final StateNotifier<double> _imageViewState = StateNotifier(initValue: 0.0);
  final StateNotifier<PlannedButtonState> _plannedState = StateNotifier(
    initValue: PlannedButtonState.disable,
  );
  final StateNotifier<String?> _plannedDateState = StateNotifier();
  final StateNotifier<bool> _routeCompleteState =
      StateNotifier(initValue: false);

  late final PageController _pageController;

  DateTime? _plannedDate;
  PlannedButtonState? _prevState;

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
  void onTapBackButton() {
    _coordinator.pop();
  }

  @override
  void onTapFavorite() {
    final prevValue = _favoriteState.value;
    if (prevValue != null) {
      _favoriteState.accept(!prevValue);

      if (!_routeCompleteState.value!) {
        _plannedState.accept(
          prevValue ? PlannedButtonState.disable : PlannedButtonState.active,
        );
      }
    }
  }

  @override
  void onTapNavigation() {
    //TODO(me): Для проверки логики UI
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
      final format = DateFormat('d MMM y', 'ru_RU');

      assert(_plannedDate != null, 'Planned date can not be null');
      _plannedDateState.accept(format.format(_plannedDate!));

      if (_plannedState.value != PlannedButtonState.haveDate) {
        _plannedState.accept(PlannedButtonState.haveDate);
      }
    }
  }

  @override
  void onTapShare() {
    // TODO: implement onTapShare
  }

  void _init() {
    _pageController = PageController()
      ..addListener(() {
        _imageViewState.accept(_pageController.page);
      });
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
}
