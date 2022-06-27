import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:elementary/elementary.dart';
import 'package:places/features/common/app_exceptions/api_exception_handler.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/service/places_service.dart';
import 'package:places/features/places_list/domain/repository/image_pick_repository.dart';
import 'package:places/features/places_list/service/image_picker_service.dart';

// TODO: cover with documentation
/// Default Elementary model for AddPlaceScreen module
class AddPlaceScreenModel extends ElementaryModel {
  final PlacesService _placesService;
  final ImagePickerService _imagePickerService;
  final ErrorHandler _errorHandler;
  final ConnectivityResult _connectivityResult;

  AddPlaceScreenModel({
    required PlacesService placesService,
    required ImagePickerService imagePickerService,
    required ErrorHandler errorHandler,
    required ConnectivityResult connectivityResult,
  })  : _placesService = placesService,
        _imagePickerService = imagePickerService,
        _errorHandler = errorHandler,
        _connectivityResult = connectivityResult;

  Future<Place?> addNewPlace(Place place, List<File> images) async {
    try {
      final result = await _placesService.addNewPlace(place, images);
      return result;
    } on Object catch (error) {
      throw apiExceptionHandle(
        error: error,
        connectivityResult: _connectivityResult,
        errorHandler: _errorHandler,
      );
    }
  }

  Future<File?> pickImage(ImagePickerSource source) =>
      _imagePickerService.pickImage(source);
}
