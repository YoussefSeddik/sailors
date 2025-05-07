import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../../data/models/auth_model.dart';
import '../../data/models/params/login_params.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<DataState<AuthModel>, LoginParams> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<DataState<AuthModel>> call({required LoginParams params}) {
    return _authRepository.login(params);
  }
}
