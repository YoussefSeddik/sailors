import 'package:sailors/src/data/models/auth_model.dart';
import 'package:sailors/src/data/models/params/confirm_phone_params.dart';
import '../../core/caching/local_storage_service.dart';
import '../../core/resources/data_state.dart';
import '../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class ConfirmPhoneUseCase
    implements UseCase<DataState<AuthModel>, ConfirmPhoneParams> {
  final AuthRepository _authRepository;
  final LocalStorageService _storageService;

  ConfirmPhoneUseCase(this._authRepository, this._storageService);

  @override
  Future<DataState<AuthModel>> call({
    required ConfirmPhoneParams params,
  }) async {
    final result = await _authRepository.confirmOtp(params);
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
