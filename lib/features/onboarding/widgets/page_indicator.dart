import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final TabController _tabController;

  const PageIndicator({
    required TabController tabController,
    Key? key,
  })  : _tabController = tabController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Positioned.fill(
      top: 600,
      child: Align(
        child: TabPageSelector(
          controller: _tabController,
          color: theme.disabledColor,
          selectedColor: theme.indicatorColor,
        ),
      ),
    );
  }
}

class Name extends StatelessWidget {
  const Name({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            
          ),
        ),
      ],
    );
  }
}
