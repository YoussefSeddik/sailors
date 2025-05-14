import '../../core/resources/data_state.dart';
import '../../core/utils/constants.dart';
import '../../core/utils/response_handler.dart';
import '../../domain/repositories/app_repository.dart';
import '../datasources/remote/app_api_service.dart';
import '../models/ad_model.dart';
import '../models/auth_model.dart';
import '../models/params/confirm_phone_params.dart';
import '../models/params/login_params.dart';
import '../models/params/register_params.dart';

class AppRepositoryImpl implements AppRepository {
  final AppApiService _api;

  AppRepositoryImpl(this._api);

  @override
  Future<DataState<AuthModel>> login(LoginParams params) {
    return handleResponse(_api.login(params.phone, params.password));
  }

  @override
  Future<DataState<AuthModel>> register(RegisterParams params) {
    return handleResponse(_api.register(params));
  }

  @override
  Future<DataState<void>> sendOtpCode(String phone) {
    return handleResponse(_api.sendOtpCode(phone));
  }

  @override
  Future<DataState<AuthModel>> confirmOtp(
    ConfirmPhoneParams confirmPhoneParams,
  ) {
    return handleResponse(
      _api.confirmOtp(confirmPhoneParams.phone, confirmPhoneParams.otp),
    );
  }

  @override
  Future<DataState<void>> updatePassword(String password) async {
    await Future.delayed(
      const Duration(milliseconds: requestMockDelayInMillis),
    );
    return DataSuccess(null);
  }

  @override
  Future<DataState<List<AdModel>>> getCurrentAds() async {
    await Future.delayed(
      const Duration(milliseconds: requestMockDelayInMillis),
    );

    return DataSuccess([
      AdModel(
        id: "1",
        title: 'سفينة للبيع',
        imageUrl: 'https://dummyimage.com/120x90/00A9C8/ffffff&text=Ad1',
        statusText: 'نشط',
        isExpired: false,
      ),
      AdModel(
        id: "2",
        title: 'لنش صيد للإيجار',
        imageUrl: 'https://dummyimage.com/120x90/006D77/ffffff&text=Ad2',
        statusText: 'متاح حتى نهاية الشهر',
        isExpired: false,
      ),
    ]);
  }

  @override
  Future<DataState<List<AdModel>>> getPreviousAds() async {
    await Future.delayed(
      const Duration(milliseconds: requestMockDelayInMillis),
    );

    return DataSuccess([
      AdModel(
        id: "3",
        title: 'مركب قديم تم بيعه',
        imageUrl: 'https://dummyimage.com/120x90/CCCCCC/ffffff&text=Ad3',
        statusText: 'انتهى العرض',
        isExpired: true,
      ),
      AdModel(
        id: "3",
        title: 'مركب قديم تم بيعه',
        imageUrl: 'https://dummyimage.com/120x90/CCCCCC/ffffff&text=Ad3',
        statusText: 'انتهى العرض',
        isExpired: true,
      ),
      AdModel(
        id: "3",
        title: 'مركب قديم تم بيعه',
        imageUrl: 'https://dummyimage.com/120x90/CCCCCC/ffffff&text=Ad3',
        statusText: 'انتهى العرض',
        isExpired: true,
      ),
      AdModel(
        id: "3",
        title: 'مركب قديم تم بيعه',
        imageUrl: 'https://dummyimage.com/120x90/CCCCCC/ffffff&text=Ad3',
        statusText: 'انتهى العرض',
        isExpired: true,
      ),
      AdModel(
        id: "3",
        title: 'مركب قديم تم بيعه',
        imageUrl: 'https://dummyimage.com/120x90/CCCCCC/ffffff&text=Ad3',
        statusText: 'انتهى العرض',
        isExpired: true,
      ),
      AdModel(
        id: "3",
        title: 'مركب قديم تم بيعه',
        imageUrl: 'https://dummyimage.com/120x90/CCCCCC/ffffff&text=Ad3',
        statusText: 'انتهى العرض',
        isExpired: true,
      ),
      AdModel(
        id: "3",
        title: 'مركب قديم تم بيعه',
        imageUrl: 'https://dummyimage.com/120x90/CCCCCC/ffffff&text=Ad3',
        statusText: 'انتهى العرض',
        isExpired: true,
      ),
      AdModel(
        id: "3",
        title: 'مركب قديم تم بيعه',
        imageUrl: 'https://dummyimage.com/120x90/CCCCCC/ffffff&text=Ad3',
        statusText: 'انتهى العرض',
        isExpired: true,
      ),
      AdModel(
        id: "3",
        title: 'مركب قديم تم بيعه',
        imageUrl: 'https://dummyimage.com/120x90/CCCCCC/ffffff&text=Ad3',
        statusText: 'انتهى العرض',
        isExpired: true,
      ),
      AdModel(
        id: "3",
        title: 'مركب قديم تم بيعه',
        imageUrl: 'https://dummyimage.com/120x90/CCCCCC/ffffff&text=Ad3',
        statusText: 'انتهى العرض',
        isExpired: true,
      ),
      AdModel(
        id: "3",
        title: 'مركب قديم تم بيعه',
        imageUrl: 'https://dummyimage.com/120x90/CCCCCC/ffffff&text=Ad3',
        statusText: 'انتهى العرض',
        isExpired: true,
      ),
    ]);
  }
}
