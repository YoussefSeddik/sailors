import 'dart:io';

import 'package:dio/dio.dart';

import '../../core/params/items_request.dart';
import '../../core/resources/data_state.dart';
import '../../domain/entities/item.dart';
import '../../domain/repositories/items_repository.dart';
import '../datasources/remote/items_api_service.dart';

class ItemsRepositoryImpl implements ItemsRepository {
  final ItemsApiService _itemsApiService;

  const ItemsRepositoryImpl(this._itemsApiService);

  @override
  Future<DataState<List<Item>>> getItems(ItemsRequestParams params) async {
    try {
      final httpResponse = await _itemsApiService.getItems(
        apiKey: params.apiKey,
        country: params.country,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data.items);
      }
      return DataFailed(
        DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ),
      );
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
