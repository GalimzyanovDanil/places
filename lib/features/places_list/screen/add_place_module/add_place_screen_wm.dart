import 'dart:io';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/common/app_exceptions/api_exception.dart';
import 'package:places/features/common/domain/entity/geoposition.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/common/strings/dialog_strings.dart';
import 'package:places/features/common/widgets/ui_func.dart';
import 'package:places/features/common/widgets/widgets_factory.dart';
import 'package:places/features/navigation/app_router.dart';
import 'package:places/features/places_list/screen/add_place_module/add_place_screen.dart';
import 'package:places/features/places_list/screen/add_place_module/add_place_screen_model.dart';
import 'package:places/features/places_list/screen/add_place_module/select_category/select_category_route.dart';
import 'package:places/features/places_list/screen/add_place_module/select_position/select_position_route.dart';
import 'package:places/features/places_list/strings/places_list_strings.dart';
import 'package:places/features/places_list/widgets/add_place_widgets/select_image_source_widget.dart';
import 'package:provider/provider.dart';
import 'package:surf_lint_rules/surf_lint_rules.dart';

abstract class IAddPlaceScreenWidgetModel extends IWidgetModel {
  ThemeData get theme;
  ListenableState<List<String>> get uploadImageState;
  ListenableState<PlaceType> get categoryState;
  ListenableState<bool> get isValidState;
  ListenableState<bool> get isLoadingProgressState;
  TextEditingController get latController;
  TextEditingController get lngController;

  GlobalKey<FormState> get formKey;
  Map<String, String> get data;

  void onSelectCategory();
  Future<void> onAddImage();
  void onDeleteImage(int index);
  Future<void> onAddNewPlace();
  void onChangeFields();
  void onCancelButton();
  void onSetOnMapButton();
  void saveFields(String key, String? value);
}

AddPlaceScreenWidgetModel defaultAddPlaceScreenWidgetModelFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();

  final model = AddPlaceScreenModel(
    placesService: appScope.placesService,
    imagePickerService: appScope.imagePickerService,
    errorHandler: appScope.errorHandler,
    connectivityResult: appScope.connectivityResult,
  );

  return AddPlaceScreenWidgetModel(
    model: model,
    router: appScope.router,
    messageController: appScope.messageController,
  );
}

// TODO(me): cover with documentation
/// Default widget model for AddPlaceScreenWidget
class AddPlaceScreenWidgetModel
    extends WidgetModel<AddPlaceScreen, AddPlaceScreenModel>
    implements IAddPlaceScreenWidgetModel {
  final AppRouter router;
  final MessageController messageController;

  final _uploadImageState = StateNotifier<List<String>>(initValue: []);
  final _categoryState = StateNotifier<PlaceType>();
  final _isValidState = StateNotifier<bool>();
  final _data = <String, String>{};
  final _formKey = GlobalKey<FormState>();
  final _isLoadingProgressState = StateNotifier<bool>(initValue: false);
  late final TextEditingController _latController;
  late final TextEditingController _lngController;

  @override
  ThemeData get theme => Theme.of(context);

  ///  Стейт для хранения и отображения изображений для загрузки
  @override
  ListenableState<List<String>> get uploadImageState => _uploadImageState;

  ///  Стейт для хранения выбранного типа места
  @override
  ListenableState<PlaceType> get categoryState => _categoryState;

  @override
  ListenableState<bool> get isValidState => _isValidState;

  @override
  GlobalKey<FormState> get formKey => _formKey;

  @override
  Map<String, String> get data => _data;

  @override
  ListenableState<bool> get isLoadingProgressState => _isLoadingProgressState;

  @override
  TextEditingController get latController => _latController;

  @override
  TextEditingController get lngController => _lngController;

  AddPlaceScreenWidgetModel({
    required this.router,
    required AddPlaceScreenModel model,
    required this.messageController,
  }) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _latController = TextEditingController();
    _lngController = TextEditingController();

    Listenable.merge([_categoryState, _uploadImageState])
        .addListener(_validateFields);
  }

  @override
  Future<void> onSelectCategory() async {
    final result = await Navigator.of(context)
        .push<PlaceType?>(SelectCategoryRoute(_categoryState.value));
    _categoryState.accept(result);
  }

  @override
  Future<void> onAddImage() async {
    final newImageFile = await _showSelectImageSource();
    if (newImageFile != null) {
      final newState = uploadImageState.value?.toList()
        ?..add(newImageFile.path);
      _uploadImageState.accept(newState);
    }
  }

  @override
  void onDeleteImage(int index) {
    final newState = uploadImageState.value?.toList()?..removeAt(index);
    _uploadImageState.accept(newState);
  }

  @override
  void onChangeFields() {
    formKey.currentState?.save();
    _validateFields();
  }

  @override
  void saveFields(String key, String? value) {
    return _data.addAll({key: value ?? ''});
  }

  @override
  Future<void> onAddNewPlace() async {
    final formValidate = formKey.currentState?.validate() ?? false;
    if (!formValidate) return;

    _isLoadingProgressState.accept(true);

    try {
      final place = Place(
        id: 0,
        lat: double.parse(_data[PlacesListStrings.lat]!),
        lng: double.parse(_data[PlacesListStrings.lng]!),
        name: _data[PlacesListStrings.name]!,
        urls: [],
        placeType: categoryState.value!,
        description: _data[PlacesListStrings.description]!,
      );

      final images =
          _uploadImageState.value!.map(File.new).toList(growable: false);

      await model.addNewPlace(place, images).then(
        (value) {
          showDialog<void>(
            context: context,
            builder: (_) {
              final isNewPlaceCreated = value != null;

              final VoidCallback onConfirm;
              final String bodyText;
              final String confirmTitle;
              final String title;

              if (isNewPlaceCreated) {
                onConfirm = router.pop;
                bodyText = PlacesListStrings.infoDialogBodyOk;
                confirmTitle = PlacesListStrings.infoDialogConfirmOk;
                title = PlacesListStrings.infoDialogTitleOk;
              } else {
                onConfirm = Navigator.of(context).pop;
                bodyText = PlacesListStrings.infoDialogBodyBad;
                confirmTitle = PlacesListStrings.infoDialogConfirmBad;
                title = PlacesListStrings.infoDialogTitleBad;
              }

              return WidgetsFactory.informDialogWidgetFactory(
                onConfirm: onConfirm,
                bodyText: bodyText,
                confirmTitle: confirmTitle,
                title: title,
              );
            },
          );
        },
      );
    } on ApiException catch (error) {
      _isLoadingProgressState.accept(false);
      switch (error.exceptionType) {
        case ApiExceptionType.network:
          unawaited(messageController.showSnackBar(
            text: DialogStrings.networkErrorSnackBarText,
            context: context,
          ));
          break;
        case ApiExceptionType.other:
          unawaited(messageController.showSnackBar(
            text: DialogStrings.otherErrorSnackBarText,
            context: context,
          ));
          break;
      }
    }
  }

  @override
  void onCancelButton() {
    router.pop();
  }

  @override
  Future<void> onSetOnMapButton() async {
    final oldPosition =
        (_latController.text.isNotEmpty && _lngController.text.isNotEmpty)
            ? Geoposition(
                latitude: double.parse(_latController.text),
                longitude: double.parse(_lngController.text),
              )
            : null;
    final newPosition = await Navigator.of(context)
        .push<Geoposition?>(SelectPositionRoute(oldPosition));
    if (newPosition != null) {
      _latController.text = newPosition.latitude.toString();
      _lngController.text = newPosition.longitude.toString();
    }
  }

  void _validateFields() {
    final isNotEmptyImage = _uploadImageState.value?.isNotEmpty ?? false;
    final isNotEmptyCategory = _categoryState.value != null;
    final isNotEmptyFields = _data.values.length == 4 &&
        !_data.values.any((element) => element.isEmpty);

    _isValidState
        .accept(isNotEmptyImage && isNotEmptyCategory && isNotEmptyFields);
  }

  Future<File?> _showSelectImageSource() async {
    final result = await showModalBottomSheet<File?>(
      isDismissible: false,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (_) => SelectImageSourceWidget(pickImage: model.pickImage),
    );
    return result;
  }
}
