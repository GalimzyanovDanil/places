import 'dart:async';

import 'package:places/features/common/service/redux/action_base.dart';
import 'package:places/features/common/service/redux/app_state.dart';
import 'package:redux/redux.dart';

abstract class AppStore {
  static Store<AppState> createStore({
    required Reducer<AppState> reducer,
    List<Middleware<AppState>> middleware = const [],
  }) =>
      Store<AppState>(
        reducer,
        initialState: const AppState(),
        middleware: middleware,
      );
}

class StoreDispatcher {
  final _controller = StreamController<ActionBase>.broadcast();

  Stream<ActionBase> get onAction => _controller.stream;

  void dispatch(ActionBase action) {
    _controller.add(action);
  }
}
