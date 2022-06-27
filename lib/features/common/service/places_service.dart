import 'dart:io';

import 'package:dio/dio.dart';
import 'package:places/api/strings/api_strings.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/domain/entity/place_filter.dart';
import 'package:places/features/common/domain/repository/places_repository.dart';

class PlacesService {
  final PlacesRepository _placesRepository;

  PlacesService(this._placesRepository);

  Future<List<Place>> getPlacesList(int count, [int offset = 0]) async {
    return _placesRepository.getPlacesList(count, offset);
  }

  Future<List<Place>> getFilteredPlace(PlaceFilter filter) async {
    return _placesRepository.getFilteredPlacesList(filter);
  }

  Future<Place?> addNewPlace(Place place, List<File> images) async {
    final requestPlace = place.copyWith(urls: []);
    try {
      for (final file in images) {
        final imagePath = await _placesRepository.uploadFiles(file);
        requestPlace.urls.add('${PlaceApiStrings.basePath}/$imagePath');
      }
    } on Object catch (e) {
      rethrow;
    }
    return _placesRepository.addNewPlace(requestPlace);
  }
}
