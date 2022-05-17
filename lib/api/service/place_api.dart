import 'package:dio/dio.dart';
import 'package:places/api/data/place_response.dart';
import 'package:places/api/strings/api_strings.dart';
import 'package:retrofit/retrofit.dart';

part 'place_api.g.dart';

/// Интерфейс API клиента.
@RestApi()
abstract class PlaceApi {
  factory PlaceApi(Dio dio, {String baseUrl}) = _PlaceApi;

  /// Запросить [count] количество мест с отступом [offset] от первого элемента в базе
  Future<List<PlaceResponse>> getPlaces(int count, [int offset = 0]) {
    final queries = <String, dynamic>{
      'count': '$count',
      'offset': '$offset',
    };
    return _getPlaces(queries);
  }

  @GET(PlaceApiStrings.place)
  Future<List<PlaceResponse>> _getPlaces(
    @Queries() Map<String, dynamic> queries,
  );
}
