import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/utils/constants.dart';
import '../../models/items_response_model.dart';

part 'items_api_service.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class ItemsApiService {
  factory ItemsApiService(Dio dio, {String baseUrl}) = _ItemsApiService;

  @GET('/top-headlines')
  Future<HttpResponse<ItemsResponseModel>> getItems({
    @Query("apiKey") required String apiKey,
    @Query("country") required String country
  });
}
