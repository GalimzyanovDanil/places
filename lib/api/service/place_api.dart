import 'package:dio/dio.dart';
import 'package:places/api/data/place_response.dart';
import 'package:places/api/strings/api_strings.dart';
import 'package:retrofit/retrofit.dart';

part 'place_api.g.dart';

/// Интерфейс API клиента.
@RestApi()
abstract class PlaceApi {
  factory PlaceApi(Dio dio, {String baseUrl}) = _PlaceApi;

  @GET(PlaceApiStrings.place)
  Future<List<PlaceResponse>> getPlaces(
    @Queries() Map<String, dynamic> queries,
  );
}
