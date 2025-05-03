import 'dart:io';
import 'package:dio/dio.dart';
import 'package:sailors/src/data/models/params/confirm_phone_params.dart';
import 'package:sailors/src/data/models/params/register_params.dart';
import '../../core/resources/data_state.dart';
import '../../core/utils/constants.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_api_service.dart';
import '../models/params/login_params.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _api;

  AuthRepositoryImpl(this._api);

  @override
  Future<DataState<UserModel>> login(LoginParams params) async {
    try {
      final response = await _api.login(params.phone, params.password);
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

  @override
  Future<DataState<UserModel>> register(RegisterParams params) async {
    await Future.delayed(
      const Duration(milliseconds: requestMockDelayInMillis),
    );
    return DataSuccess(UserModel(name: "", phone: "", token: ""));
    try {
      final response = await _api.register(
        params.name,
        params.phone,
        params.password,
      );
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

  @override
  Future<DataState<void>> sendOtpCode(String phone) async {
    try {
      await Future.delayed(
        const Duration(milliseconds: requestMockDelayInMillis),
      );
      return DataSuccess(null);
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<UserModel>> confirmOtp(
    ConfirmPhoneParams confirmPhoneParams,
  ) async {
    await Future.delayed(
      const Duration(milliseconds: requestMockDelayInMillis),
    );
    return DataSuccess(UserModel(name: "", phone: "", token: ""));
  }

  @override
  Future<DataState<void>> updatePassword(String password) async {
    await Future.delayed(
      const Duration(milliseconds: requestMockDelayInMillis),
    );
    return DataSuccess(null);
  }
}
