import 'package:dio/dio.dart';
import 'package:places/api/data/place_add_request.dart';
import 'package:places/api/data/place_filter_request.dart';
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

  @POST(PlaceApiStrings.filteredPlace)
  Future<List<PlaceResponse>> getFilteredPlace(
    @Body() PlaceFilterRequest request,
  );

  @POST(PlaceApiStrings.place)
  Future<PlaceResponse> addNewPlace(
    @Body() PlaceAddRequest request,
  );

  // https://github.com/trevorwang/retrofit.dart/pull/272
  @POST(PlaceApiStrings.uploadFiles)
  Future<HttpResponse<dynamic>> uploadFiles(
    @Part() List<MultipartFile> files,
  );
}
