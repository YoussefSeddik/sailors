import 'package:sailors/src/data/models/auth_model.dart';
import 'package:sailors/src/data/models/params/register_params.dart';
import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase implements UseCase<DataState<AuthModel>, RegisterParams> {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  @override
  Future<DataState<AuthModel>> call({required RegisterParams params}) {
    return _authRepository.register(params);
  }
}
