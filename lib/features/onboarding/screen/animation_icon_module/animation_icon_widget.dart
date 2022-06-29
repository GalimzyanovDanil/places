import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/features/onboarding/screen/animation_icon_module/animation_icon_wm.dart';

// TODO(me): cover with documentation
/// Main widget for AnimationIcon module
class AnimationIconWidget extends ElementaryWidget<IAnimationIconWidgetModel> {
  final String _iconPath;

  const AnimationIconWidget({
    required String iconPath,
    Key? key,
    WidgetModelFactory wmFactory = defaultAnimationIconWidgetModelFactory,
  })  : _iconPath = iconPath,
        super(wmFactory, key: key);

  @override
  Widget build(IAnimationIconWidgetModel wm) {
    return ScaleTransition(
      scale: wm.animation,
      child: SvgPicture.asset(
        _iconPath,
        color: wm.theme.iconTheme.color,
        height: 125,
        width: 125,
      ),
    );
  }
}
