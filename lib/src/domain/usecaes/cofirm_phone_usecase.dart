import 'package:sailors/src/data/models/auth_model.dart';
import 'package:sailors/src/data/models/params/confirm_phone_params.dart';
import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class ConfirmPhoneUseCase
    implements UseCase<DataState<AuthModel>, ConfirmPhoneParams> {
  final AuthRepository _authRepository;

  ConfirmPhoneUseCase(this._authRepository);

  @override
  Future<DataState<AuthModel>> call({required ConfirmPhoneParams params}) {
    return _authRepository.confirmOtp(params);
  }
}
