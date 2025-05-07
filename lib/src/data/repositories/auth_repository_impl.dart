import '../../core/resources/data_state.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/response_handler.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_api_service.dart';
import '../models/auth_model.dart';
import '../models/params/confirm_phone_params.dart';
import '../models/params/login_params.dart';
import '../models/params/register_params.dart'; // 👈 import your handler

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService _api;

  AuthRepositoryImpl(this._api);

  @override
  Future<DataState<AuthModel>> login(LoginParams params) {
    return handleResponse(_api.login(params.phone, params.password));
  }

  @override
  Future<DataState<AuthModel>> register(RegisterParams params) {
    return handleResponse(
      _api.register(params.name, params.phone, params.password),
    );
  }

  @override
  Future<DataState<void>> sendOtpCode(String phone) {
    return handleResponse(_api.sendOtpCode(phone));
  }

  @override
  Future<DataState<AuthModel>> confirmOtp(
    ConfirmPhoneParams confirmPhoneParams,
  ) {
    return handleResponse(
      _api.confirmOtp(confirmPhoneParams.phone, confirmPhoneParams.otp),
    );
  }

  @override
  Future<DataState<void>> updatePassword(String password) async {
    await Future.delayed(
      const Duration(milliseconds: requestMockDelayInMillis),
    );
    return DataSuccess(null);
  }
}
