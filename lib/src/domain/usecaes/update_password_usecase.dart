import 'package:sailors/src/data/models/params/confirm_phone_params.dart';
import 'package:sailors/src/data/models/params/update_password_params.dart';
import 'package:sailors/src/data/models/user_model.dart';
import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class UpdatePasswordUseCase
    implements UseCase<DataState<void>, UpdatePasswordParams> {
  final AuthRepository _authRepository;

  UpdatePasswordUseCase(this._authRepository);

  @override
  Future<DataState<void>> call({required UpdatePasswordParams params}) {
    return _authRepository.updatePassword(params.password);
  }
}
