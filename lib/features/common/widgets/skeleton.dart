import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  final bool? enabled;
  final double? width;
  final double height;
  final Color? baseColor;
  final Color? highlightColor;
  final BorderRadius? borderRadius;
  final Widget? child;

  const Skeleton({
    required this.height,
    this.width,
    this.child,
    this.enabled,
    this.baseColor,
    this.highlightColor,
    this.borderRadius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Shimmer.fromColors(
      enabled: enabled ?? true,
      baseColor: baseColor ?? colorScheme.onBackground,
      highlightColor: highlightColor ?? colorScheme.surface.withOpacity(0.5),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Container(
          // TODO(me): Почему если убрать цвет или заменить на контейнер на SizedBox,
          // то шиммер перестает отображаться
          color: Colors.green,
          width: width ?? double.infinity,
          height: height,
          child: child ?? const SizedBox.expand(),
        ),
      ),
    );
  }
}
