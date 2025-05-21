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

    if (isSuccessfulStatus(response.response.statusCode) && api.success) {
      return DataSuccess(api.data as T);
    }

    if (!api.success) {
      return DataFailed(api.message ?? 'Unknown error');
    }

    return DataFailed(_extractFirstError(api.errors));
  } on DioException catch (e) {
    return DataFailed(_extractErrorMessage(e));
  } catch (e) {
    return DataFailed('Unexpected error occurred');
  }
}


bool isSuccessfulStatus(int? statusCode) {
  final code = statusCode ?? 0;
  return code >= 200 && code < 300;
}

String? _extractFirstError(Map<String, List<String>>? errors) {
  return errors?.values.firstOrNull?.first;
}

String? _extractErrorMessage(DioException e) {
  try {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      if (data.containsKey('msg')) {
        return ApiErrorModel.fromJson(data).msg;
      }

      if (data.containsKey('errors')) {
        final errors = data['errors'] as Map<String, dynamic>;
        final firstList = errors.values.first;
        if (firstList is List && firstList.isNotEmpty) {
          return firstList.first.toString();
        }
      }

      return data['message'] ?? e.message;
    }
  } catch (_) {
    // fallback
  }
  return e.message;
}

class ApiErrorModel {
  final bool value;
  final String msg;

  ApiErrorModel({required this.value, required this.msg});

  factory ApiErrorModel.fromJson(Map<String, dynamic> json) {
    return ApiErrorModel(
      value: json['value'] ?? false,
      msg: json['msg'] ?? 'Unknown error',
    );
  }
}
