import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class SendOtpUseCase implements UseCase<DataState<void>, String> {
  final AuthRepository _authRepository;

  SendOtpUseCase(this._authRepository);

  @override
  Future<DataState<void>> call({required String params}) {
    return _authRepository.sendOtpCode(params);
  }
}
