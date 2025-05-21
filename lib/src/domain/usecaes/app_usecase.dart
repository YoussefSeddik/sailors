import 'package:sailors/src/core/caching/local_storage_service.dart';
import 'package:sailors/src/core/resources/data_state.dart';
import 'package:sailors/src/data/models/ad_model.dart';
import 'package:sailors/src/data/models/auth_model.dart';
import 'package:sailors/src/data/models/category_model.dart';
import 'package:sailors/src/data/models/package_model.dart';
import 'package:sailors/src/domain/repositories/app_repository.dart';

import '../../data/models/advertise_model.dart';
import '../../data/models/user_model.dart';

class AppUseCases {
  final AppRepository _repo;
  final LocalStorageService _storage;

  AppUseCases(this._repo, this._storage);

  Future<DataState<AuthModel>> login(params) async {
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

  Future<DataState<AuthModel>> register(params) async {
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

  Future<DataState<UserModel>> sendOtp(phoneNumber) {
    return _repo.sendOtpCode(phoneNumber);
  }

  Future<DataState<AuthModel>> confirmPhone(params) async {
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

  Future<DataState<void>> updatePassword(params) {
    return _repo.updatePassword(params);
  }

  Future<DataState<List<AdModel>>> getCurrentAds() {
    return _repo.getCurrentAds();
  }

  Future<DataState<List<AdModel>>> getPreviousAds() {
    return _repo.getPreviousAds();
  }

  Future<DataState<AuthModel>> confirmOtp(confirmPhoneParams) {
    return _repo.confirmOtp(confirmPhoneParams);
  }

  Future<DataState<void>> sendOtpCode(phone) {
    return _repo.sendOtpCode(phone);
  }

  Future<DataState<UserModel>> updateProfile(params) async {
    final result = await _repo.updateProfile(params);

    if (result.data != null) {
      final authModel = await _storage.getModelAsync<AuthModel>(
        AuthModel.storageKey,
        AuthModel.fromJson,
      );
      if (authModel != null) {
        authModel.user = result.data!;
        await _storage.saveModel<AuthModel>(
          AuthModel.storageKey,
          authModel,
          (m) => m.toJson(),
        );
      }
    }

    return result;
  }

  Future<DataState<void>> contactUs(params) {
    return _repo.contactUs(params);
  }

  Future<DataState<void>> sendSupport(params) {
    return _repo.sendSupport(params);
  }

  Future<DataState<AdvertiseModel>> createAdvertisement(params) {
    return _repo.createAdvertisement(params);
  }
  Future<DataState<List<PackageModel>>> getAllPackages() {
    return _repo.getAllPackages();
  }

  Future<DataState<List<CategoryModel>>> getAllCategories() {
    return _repo.getAllCategories();
  }
}
