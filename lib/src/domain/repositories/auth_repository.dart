import 'package:sailors/src/data/models/params/register_params.dart';
import '../../core/resources/data_state.dart';
import '../../data/models/auth_model.dart';
import '../../data/models/params/confirm_phone_params.dart';
import '../../data/models/params/login_params.dart';

abstract class AuthRepository {
  Future<DataState<AuthModel>> login(LoginParams params);

  Future<DataState<AuthModel>> register(RegisterParams params);

  Future<DataState<void>> sendOtpCode(String phone);

  Future<DataState<AuthModel>> confirmOtp(ConfirmPhoneParams confirmPhoneParams);

  Future<DataState<void>> updatePassword(String password);
}
