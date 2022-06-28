import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/common/domain/entity/place_type.dart';
import 'package:places/features/places_list/screen/add_place_module/select_category/select_category_model.dart';
import 'package:places/features/places_list/screen/add_place_module/select_category/select_category_screen.dart';

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
  final model = SelectCategoryModel();
  return SelectCategoryWidgetModel(
    model: model,
  );
}

// TODO: cover with documentation
/// Default widget model for SelectCategoryWidget
class SelectCategoryWidgetModel
    extends WidgetModel<SelectCategoryScreen, SelectCategoryModel>
    implements ISelectCategoryWidgetModel {
  late final StateNotifier<int> _selectCategoryState;

  final _typeList = PlaceType.values;

  @override
  ThemeData get theme => Theme.of(context);

  @override
  ListenableState<int> get selectCategoryState => _selectCategoryState;

  SelectCategoryWidgetModel({
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
  void onBackButton() => Navigator.of(context).pop(widget.type);

  @override
  void onSaveButton() {
    Navigator.of(context).pop(_typeList[_selectCategoryState.value!]);
  }
}
