import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';

class TripleStateNotifierBuilder<T, K, V> extends StatelessWidget {
  final ListenableState<T> listenableState1;
  final ListenableState<K> listenableState2;
  final ListenableState<V> listenableState3;
  final Widget Function(T? value1, K? value2, V? value3) builder;

  const TripleStateNotifierBuilder({
    required this.listenableState1,
    required this.listenableState2,
    required this.listenableState3,
    required this.builder,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StateNotifierBuilder<T>(
      listenableState: listenableState1,
      builder: (_, value1) => StateNotifierBuilder<K>(
        listenableState: listenableState2,
        builder: (_, value2) => StateNotifierBuilder<V>(
          listenableState: listenableState3,
          builder: (_, value3) => builder.call(value1, value2, value3),
        ),
      ),
    );
  }
}
