import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int _currentPage;

  const PageIndicator({
    required int currentPage,
    Key? key,
  })  : _currentPage = currentPage,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      top: 400,
      child: Align(
        child: Indicator(
          currentPage: _currentPage,
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final int currentPage;
  const Indicator({required this.currentPage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const size = 8.0;
    final Widget active = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        width: 24,
        height: size,
        decoration: BoxDecoration(
          color: theme.indicatorColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(size),
          ),
        ),
      ),
    );

    final children = <Widget>[
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: theme.disabledColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(size),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: theme.disabledColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(size),
            ),
          ),
        ),
      ),
    ]..insert(currentPage, active);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
