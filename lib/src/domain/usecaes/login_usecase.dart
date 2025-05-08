import '../../core/caching/local_storage_service.dart';
import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../../data/models/auth_model.dart';
import '../../data/models/params/login_params.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<DataState<AuthModel>, LoginParams> {
  final AuthRepository _authRepository;
  final LocalStorageService _storageService;

  LoginUseCase(this._authRepository, this._storageService);

  @override
  Future<DataState<AuthModel>> call({required LoginParams params}) async {
    final result = await _authRepository.login(params);
    if (result.data != null) {
      await _storageService.saveModel<AuthModel>(
        AuthModel.storageKey,
        result.data!,
        (m) => m.toJson(),
      );
    }
    return result;
  }
}
