import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/app/di/app_scope.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/navigation/service/coordinator.dart';
import 'package:places/features/places_list/screen/add_place_module/select_category/select_category_model.dart';
import 'package:places/features/places_list/screen/add_place_module/select_category/select_category_screen.dart';
import 'package:provider/provider.dart';

abstract class ISelectCategoryWidgetModel extends IWidgetModel {
  ThemeData get theme;
  ListenableState<int> get selectCategoryState;
  void selectCategory(int index);
  void onBackButton();
  void onSaveButton();
}

SelectCategoryWidgetModel defaultSelectCategoryWidgetModelFactory(
  BuildContext context,
) {
  final appScope = context.read<IAppScope>();
  final model = SelectCategoryModel();
  return SelectCategoryWidgetModel(
    model: model,
    coordinator: appScope.coordinator,
  );
}

// TODO: cover with documentation
/// Default widget model for SelectCategoryWidget
class SelectCategoryWidgetModel
    extends WidgetModel<SelectCategoryScreen, SelectCategoryModel>
    implements ISelectCategoryWidgetModel {
  late final StateNotifier<int> _selectCategoryState;

  final _typeList = PlaceType.values;
  final Coordinator coordinator;

  @override
  ThemeData get theme => Theme.of(context);

  @override
  ListenableState<int> get selectCategoryState => _selectCategoryState;

  SelectCategoryWidgetModel({
    required this.coordinator,
    required SelectCategoryModel model,
  }) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();
    int? defaultValue;

    if (widget.type != null) {
      defaultValue = _typeList.indexOf(widget.type!);
    }

    _selectCategoryState = StateNotifier<int>(initValue: defaultValue);
  }

  @override
  void selectCategory(int index) {
    _selectCategoryState.accept(index);
  }

  @override
  void onBackButton() => coordinator.pop(context);

  @override
  void onSaveButton() {
    coordinator.pop(context, arguments: _typeList[_selectCategoryState.value!]);
  }
}
