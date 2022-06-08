import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

class DoubleStateNotifierBuilder<T, K> extends StatelessWidget {
  final ListenableState<T> listenableState1;
  final ListenableState<K> listenableState2;
  final Widget Function(T? value1, K? value2) builder;

  const DoubleStateNotifierBuilder({
    required this.listenableState1,
    required this.listenableState2,
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder<T>(
      listenableState: listenableState1,
      builder: (_, value1) => StateNotifierBuilder<K>(
        listenableState: listenableState2,
        builder: (_, value2) => builder.call(value1, value2),
      ),
    );
  }
}
