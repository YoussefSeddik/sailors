import 'package:sailors/src/data/models/params/confirm_phone_params.dart';
import 'package:sailors/src/data/models/user_model.dart';
import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class ConfirmPhoneUseCase
    implements UseCase<DataState<UserModel>, ConfirmPhoneParams> {
  final AuthRepository _authRepository;

  ConfirmPhoneUseCase(this._authRepository);

  @override
  Future<DataState<UserModel>> call({required ConfirmPhoneParams params}) {
    return _authRepository.confirmOtp(params);
  }
}
