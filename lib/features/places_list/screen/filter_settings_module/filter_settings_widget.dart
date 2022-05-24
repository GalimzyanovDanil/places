import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/places_list/screen/filter_settings_module/filter_settings_wm.dart';


// TODO: cover with documentation
/// Main widget for FilterSettings module
class FilterSettingsWidget extends ElementaryWidget<IFilterSettingsWidgetModel> {
  const FilterSettingsWidget({
    Key? key,
    WidgetModelFactory wmFactory = defaultFilterSettingsWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IFilterSettingsWidgetModel wm) {
    return Container();
  }
}
