import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:places/features/onboarding/screen/animation_icon_module/animation_icon_model.dart';
import 'package:places/features/onboarding/screen/animation_icon_module/animation_icon_widget.dart';

abstract class IAnimationIconWidgetModel extends IWidgetModel {
  Animation<double> get animation;
  ThemeData get theme;
}

AnimationIconWidgetModel defaultAnimationIconWidgetModelFactory(
  BuildContext context,
) {
  final model = AnimationIconModel();
  return AnimationIconWidgetModel(model);
}

// TODO: cover with documentation
/// Default widget model for AnimationIconWidget
class AnimationIconWidgetModel
    extends WidgetModel<AnimationIconWidget, AnimationIconModel>
    with TickerProviderWidgetModelMixin
    implements IAnimationIconWidgetModel {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  Animation<double> get animation => _animation;

  @override
  ThemeData get theme => Theme.of(context);

  AnimationIconWidgetModel(AnimationIconModel model) : super(model);

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
