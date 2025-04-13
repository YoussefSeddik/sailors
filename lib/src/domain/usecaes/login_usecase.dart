import 'package:sailors/src/data/models/user_model.dart';
import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../../data/models/params/login_params.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<DataState<UserModel>, LoginParams> {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  @override
  Future<DataState<UserModel>> call({required LoginParams params}) {
    return _authRepository.login(params);
  }
}
