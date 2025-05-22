import 'package:sailors/src/data/models/advertise_model.dart';
import 'package:sailors/src/data/models/category_model.dart';
import 'package:sailors/src/data/models/package_model.dart';

import 'package:sailors/src/data/models/params/create_advertise_params.dart';

import '../../core/resources/data_state.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/response_handler.dart';
import '../../domain/repositories/app_repository.dart';
import '../datasources/remote/app_api_service.dart';
import '../models/ad_model.dart';
import '../models/auth_model.dart';
import '../models/notification_model.dart';
import '../models/params/send_otp_params.dart';
import '../models/user_model.dart';

class AppRepositoryImpl implements AppRepository {
  final AppApiService _api;

  AppRepositoryImpl(this._api);

  @override
  Future<DataState<AuthModel>> login(params) {
    return handleResponse(_api.login(params.phone, params.password));
  }

  @override
  Future<DataState<AuthModel>> register(params) {
    return handleResponse(_api.register(params));
  }

  @override
  Future<DataState<UserModel>> sendOtpCode(phone) {
    return handleResponse(_api.sendOtpCode(SendOtpParams(phone: phone)));
  }

  @override
  Future<DataState<AuthModel>> confirmOtp(confirmPhoneParams) {
    return handleResponse(
      _api.confirmOtp(confirmPhoneParams.phone, confirmPhoneParams.otp),
    );
  }

  @override
  Future<DataState<void>> updatePassword(updatePasswordParams) {
    return handleResponse(_api.updatePassword(updatePasswordParams));
  }

  @override
  Future<DataState<List<AdvertiseModel>>> getCurrentAds() async {
    return handleResponse(_api.getCurrentAds());
  }

  @override
  Future<DataState<List<AdvertiseModel>>> getPreviousAds() async {
    return handleResponse(_api.getPrevAds());
  }

  @override
  Future<DataState<UserModel>> updateProfile(params) async {
    return handleResponse(
      _api.updateProfile(params.name, params.phone, params.avatar),
    );
  }

  @override
  Future<DataState<void>> sendSupport(params) async {
    return handleResponse(_api.sendSupport(params));
  }

  @override
  Future<DataState<void>> contactUs(params) async {
    return handleResponse(_api.contactUs(params));
  }

  @override
  Future<DataState<AdvertiseModel>> createAdvertisement(
      CreateAdvertiseParams params,
      ) {
    return handleResponse(
      _api.createAdvertisement(
        params.name,
        params.details,
        params.categoryId,
        params.packageId,
        params.advertisementTypeId,
        params.type,
        params.status,
        params.phone,
        params.whatsapp,
        params.adPrice,
        params.coupon,
        params.images,
      ),
    );
  }

  @override
  Future<DataState<List<PackageModel>>> getAllPackages() {
    return handleResponse(_api.getAllPackages());
  }

  @override
  Future<DataState<List<CategoryModel>>> getAllCategories() {
    return handleResponse(_api.getAllCategories());
  }

  @override
  Future<DataState<List<NotificationModel>>> getNotifications() async {
    await Future.delayed(const Duration(seconds: 2));

    final fakeData = [
      NotificationModel(
        title: 'Welcome!',
        desc: 'Thanks for joining our platform.',
        image: 'https://via.placeholder.com/150',
      ),
      NotificationModel(
        title: 'New Feature',
        desc: 'Check out the latest updates now.',
        image: 'https://via.placeholder.com/150',
      ),
    ];

    return DataSuccess(fakeData);
  }

}
