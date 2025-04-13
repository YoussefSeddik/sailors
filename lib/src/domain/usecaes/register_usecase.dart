import 'package:sailors/src/data/models/params/register_params.dart';
import 'package:sailors/src/data/models/user_model.dart';
import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase implements UseCase<DataState<UserModel>, RegisterParams> {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  @override
  Future<DataState<UserModel>> call({required RegisterParams params}) {
    return _authRepository.register(params);
  }
}
