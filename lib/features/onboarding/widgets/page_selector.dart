import 'package:flutter/material.dart';

class PageSelector extends StatelessWidget {
  final TabController _tabController;

  const PageSelector({
    required TabController tabController,
    Key? key,
  })  : _tabController = tabController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabPageSelector(
      controller: _tabController,
      color: Theme.of(context).disabledColor,
      selectedColor: Theme.of(context).indicatorColor,
    );
  }
}
