// ignore_for_file: public_member_api_docs

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/temp/screens/temp_screen/temp_screen.dart';
import 'package:places/features/temp/screens/temp_screen/temp_screen_model.dart';

/// Factory for [TempScreenWidgetModel].
TempScreenWidgetModel initScreenWidgetModelFactory(
  BuildContext context,
) {
  final model = TempScreenModel();
  return TempScreenWidgetModel(model);
}

/// Widget model for [TempScreen].
class TempScreenWidgetModel extends WidgetModel<TempScreen, TempScreenModel>
    implements IDebugWidgetModel {
  // final BuildContext context;
  @override
  TextStyle get style1 =>
      Theme.of(context).textTheme.headline2 ?? const TextStyle();

  /// Create an instance [TempScreenWidgetModel].
  TempScreenWidgetModel(TempScreenModel model) : super(model);
}

/// Interface of [TempScreenWidgetModel].
abstract class IDebugWidgetModel extends IWidgetModel {
  TextStyle get style1;
}
