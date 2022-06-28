import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:places/api/service/place_api.dart';
import 'package:places/features/common/domain/entity/place.dart';
import 'package:places/features/common/domain/entity/place_filter.dart';
import 'package:places/features/common/domain/repository/mappers/place_mapper.dart';

class PlacesRepository {
  final PlaceApi _apiClient;

  PlacesRepository(this._apiClient);

  /// Запросить [count] количество мест с отступом [offset] от первого элемента в базе
  Future<List<Place>> getPlacesList(int count, [int offset = 0]) async {
    final queries = <String, dynamic>{
      'count': '$count',
      'offset': '$offset',
    };
    return _apiClient
        .getPlaces(queries)
        .then((value) => value.map<Place>(mapResponseToPlace).toList());
  }

  Future<List<Place>> getFilteredPlacesList(PlaceFilter filter) async {
    return _apiClient
        .getFilteredPlace(mapPlaceFilterToRequest(filter))
        .then((value) => value.map<Place>(mapResponseToPlace).toList());
  }

  Future<Place?> addNewPlace(Place place) => _apiClient
      .addNewPlace(mapPlaceToPlaceAddRequest(place))
      .then<Place?>(mapResponseToPlace);

  Future<String?> uploadFiles(File data) async {
    try {
      final response = await _apiClient.uploadFiles([
        MultipartFile.fromFileSync(
          data.path,
          filename: 'image',
          contentType: MediaType('image', _getMimeSubtype(data)),
        ),
      ]);
      return response.response.headers['location']?.first;
    } on Object catch (_) {
      rethrow;
    }
  }

  // Получение типа отправляемых изображений
  String _getMimeSubtype(File data) {
    const jpeg = 'jpeg';
    const jpg = 'jpg';
    const png = 'png';
    const gif = 'gif';
    const svg = 'svg';

    final dataType = data.path.split('.').last;
    switch (dataType) {
      case jpeg:
      case jpg:
        return jpeg;
      case png:
        return png;
      case gif:
        return gif;
      case svg:
        return svg;
      default:
        throw Exception('The image type is not supported');
    }
  }
}
