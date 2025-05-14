import 'package:sailors/src/core/caching/local_storage_service.dart';
import 'package:sailors/src/core/resources/data_state.dart';
import 'package:sailors/src/data/models/ad_model.dart';
import 'package:sailors/src/data/models/auth_model.dart';
import 'package:sailors/src/data/models/params/confirm_phone_params.dart';
import 'package:sailors/src/data/models/params/login_params.dart';
import 'package:sailors/src/data/models/params/register_params.dart';
import 'package:sailors/src/data/models/params/update_password_params.dart';
import 'package:sailors/src/domain/repositories/app_repository.dart';

class AppUseCases {
  final AppRepository _repo;
  final LocalStorageService _storage;

  AppUseCases(this._repo, this._storage);

  Future<DataState<AuthModel>> login(LoginParams params) async {
    final result = await _repo.login(params);
    if (result.data != null) {
      await _storage.saveModel<AuthModel>(
        AuthModel.storageKey,
        result.data!,
            (m) => m.toJson(),
      );
    }
    return result;
  }

  Future<DataState<AuthModel>> register(RegisterParams params) async {
    final result = await _repo.register(params);
    if (result.data != null) {
      await _storage.saveModel<AuthModel>(
        AuthModel.storageKey,
        result.data!,
            (m) => m.toJson(),
      );
    }
    return result;
  }

  Future<DataState<void>> sendOtp(String phoneNumber) {
    return _repo.sendOtpCode(phoneNumber);
  }

  Future<DataState<AuthModel>> confirmPhone(ConfirmPhoneParams params) async {
    final result = await _repo.confirmOtp(params);
    if (result.data != null) {
      await _storage.saveModel<AuthModel>(
        AuthModel.storageKey,
        result.data!,
            (m) => m.toJson(),
      );
    }
    return result;
  }

  Future<DataState<void>> updatePassword(UpdatePasswordParams params) {
    return _repo.updatePassword(params.password);
  }

  Future<DataState<List<AdModel>>> getCurrentAds() {
    return _repo.getCurrentAds();
  }

  Future<DataState<List<AdModel>>> getPreviousAds() {
    return _repo.getPreviousAds();
  }
}
