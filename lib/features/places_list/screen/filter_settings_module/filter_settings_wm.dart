import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_model.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_widget.dart';

abstract class IFilterSettingsWidgetModel extends IWidgetModel {}

FilterSettingsWidgetModel defaultFilterSettingsWidgetModelFactory(
    BuildContext context) {
  final model = FilterSettingsModel();
  return FilterSettingsWidgetModel(model);
}

// TODO: cover with documentation
/// Default widget model for FilterSettingsWidget
class FilterSettingsWidgetModel
    extends WidgetModel<FilterSettingsWidget, FilterSettingsModel>
    implements IFilterSettingsWidgetModel {
  FilterSettingsWidgetModel(FilterSettingsModel model) : super(model);
}
