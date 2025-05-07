import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../resources/data_state.dart';
import 'api_response.dart';

Future<DataState<T>> handleResponse<T>(
  Future<HttpResponse<ApiResponse<T>>> future,
) async {
  try {
    final response = await future;
    final api = response.data;

    if (isSuccessfulStatus(response.response.statusCode) && api.data != null) {
      return DataSuccess(api.data as T);
    }

    return _fail(
      response.response.requestOptions,
      response.response,
      api.message ?? _extractFirstError(api.errors),
    );
  } on DioException catch (e) {
    return _fail(e.requestOptions, e.response, _extractErrorMessage(e));
  }
}

bool isSuccessfulStatus(int? statusCode) {
  final code = statusCode ?? 0;
  return code >= 200 && code < 300;
}

DataFailed<T> _fail<T>(
  RequestOptions request,
  Response? response,
  String? message,
) {
  return DataFailed(
    DioException(
      requestOptions: request,
      response: response,
      type: DioExceptionType.badResponse,
      message: message ?? "Something went wrong",
    ),
  );
}

String? _extractFirstError(Map<String, List<String>>? errors) {
  return errors?.values.firstOrNull?.first;
}

String? _extractErrorMessage(DioException e) {
  try {
    final data = e.response?.data;
    if (data is Map && data.containsKey('errors')) {
      final errors = data['errors'] as Map<String, dynamic>;
      final firstList = errors.values.first;
      if (firstList is List && firstList.isNotEmpty) {
        return firstList.first.toString();
      }
    }
    return data['message'] ?? e.message;
  } catch (_) {
    return e.message;
  }
}
