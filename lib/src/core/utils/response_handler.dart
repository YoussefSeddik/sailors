import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../resources/data_state.dart';

Future<DataState<T>> handleResponse<T>(Future<HttpResponse<T>> future) async {
  try {
    final response = await future;
    if (response.response.statusCode == HttpStatus.ok) {
      return DataSuccess(response.data);
    } else {
      return DataFailed(
        DioException(
          requestOptions: response.response.requestOptions,
          response: response.response,
          type: DioExceptionType.badResponse,
        ),
      );
    }
  } on DioException catch (e) {
    return DataFailed(e);
  }
}
