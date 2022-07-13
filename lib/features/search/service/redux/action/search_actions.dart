import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/service/redux/action_base.dart';

//TODO(me): Rework on Freezed package?

// ignore: one_member_abstracts
abstract class SearchAction {
  T map<T>({
    required T Function(SearchAction action) fetchRequestHistoryAction,
    required T Function(SearchAction action) deleteRequestHistoryAction,
    required T Function(SearchAction action) clearRequestHistoryAction,
    required T Function(SearchAction action) fetchPlaceListAction,
    required T Function(SearchAction action) addRequestHistoryAction,
    required T Function(SearchAction action) receivedHistoryAction,
    required T Function(SearchAction action) receivedPlacesAction,
  });
}

class FetchRequestHistoryAction extends ActionBase implements SearchAction {
  @override
  T map<T>({
    required T Function(SearchAction action) fetchRequestHistoryAction,
    required T Function(SearchAction action) deleteRequestHistoryAction,
    required T Function(SearchAction action) clearRequestHistoryAction,
    required T Function(SearchAction action) fetchPlaceListAction,
    required T Function(SearchAction action) addRequestHistoryAction,
    required T Function(SearchAction action) receivedHistoryAction,
    required T Function(SearchAction action) receivedPlacesAction,
  }) =>
      fetchRequestHistoryAction(this);
}

class AddRequestHistoryAction implements SearchAction {
  final String textRequest;
  const AddRequestHistoryAction(this.textRequest);

  @override
  T map<T>({
    required T Function(SearchAction action) fetchRequestHistoryAction,
    required T Function(SearchAction action) deleteRequestHistoryAction,
    required T Function(SearchAction action) clearRequestHistoryAction,
    required T Function(SearchAction action) fetchPlaceListAction,
    required T Function(SearchAction action) addRequestHistoryAction,
    required T Function(SearchAction action) receivedHistoryAction,
    required T Function(SearchAction action) receivedPlacesAction,
  }) =>
      addRequestHistoryAction(this);
}

class DeleteRequestHistoryAction implements SearchAction {
  final String textRequest;
  const DeleteRequestHistoryAction(this.textRequest);

  @override
  T map<T>({
    required T Function(SearchAction action) fetchRequestHistoryAction,
    required T Function(SearchAction action) deleteRequestHistoryAction,
    required T Function(SearchAction action) clearRequestHistoryAction,
    required T Function(SearchAction action) fetchPlaceListAction,
    required T Function(SearchAction action) addRequestHistoryAction,
    required T Function(SearchAction action) receivedHistoryAction,
    required T Function(SearchAction action) receivedPlacesAction,
  }) =>
      deleteRequestHistoryAction(this);
}

class ClearRequestHistoryAction implements SearchAction {
  @override
  T map<T>({
    required T Function(SearchAction action) fetchRequestHistoryAction,
    required T Function(SearchAction action) deleteRequestHistoryAction,
    required T Function(SearchAction action) clearRequestHistoryAction,
    required T Function(SearchAction action) fetchPlaceListAction,
    required T Function(SearchAction action) addRequestHistoryAction,
    required T Function(SearchAction action) receivedHistoryAction,
    required T Function(SearchAction action) receivedPlacesAction,
  }) =>
      clearRequestHistoryAction(this);
}

class FetchPlaceListAction implements SearchAction {
  final String query;
  const FetchPlaceListAction(this.query);

  @override
  T map<T>({
    required T Function(SearchAction action) fetchRequestHistoryAction,
    required T Function(SearchAction action) deleteRequestHistoryAction,
    required T Function(SearchAction action) clearRequestHistoryAction,
    required T Function(SearchAction action) fetchPlaceListAction,
    required T Function(SearchAction action) addRequestHistoryAction,
    required T Function(SearchAction action) receivedHistoryAction,
    required T Function(SearchAction action) receivedPlacesAction,
  }) =>
      fetchPlaceListAction(this);
}

class ReceivedHistoryAction implements SearchAction {
  final List<String> queryHistory;
  ReceivedHistoryAction(this.queryHistory);

  @override
  T map<T>({
    required T Function(SearchAction action) fetchRequestHistoryAction,
    required T Function(SearchAction action) deleteRequestHistoryAction,
    required T Function(SearchAction action) clearRequestHistoryAction,
    required T Function(SearchAction action) fetchPlaceListAction,
    required T Function(SearchAction action) addRequestHistoryAction,
    required T Function(SearchAction action) receivedHistoryAction,
    required T Function(SearchAction action) receivedPlacesAction,
  }) =>
      receivedHistoryAction(this);
}

class ReceivedPlacesAction implements SearchAction {
  final List<Place> findedPlaces;
  ReceivedPlacesAction(this.findedPlaces);

  @override
  T map<T>({
    required T Function(SearchAction action) fetchRequestHistoryAction,
    required T Function(SearchAction action) deleteRequestHistoryAction,
    required T Function(SearchAction action) clearRequestHistoryAction,
    required T Function(SearchAction action) fetchPlaceListAction,
    required T Function(SearchAction action) addRequestHistoryAction,
    required T Function(SearchAction action) receivedHistoryAction,
    required T Function(SearchAction action) receivedPlacesAction,
  }) =>
      receivedPlacesAction(this);
}
