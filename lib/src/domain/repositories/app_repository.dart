import 'package:sailors/src/data/models/advertise_model.dart';
import 'package:sailors/src/data/models/category_model.dart';
import 'package:sailors/src/data/models/package_model.dart';
import 'package:sailors/src/data/models/params/create_advertise_params.dart';
import 'package:sailors/src/data/models/params/register_params.dart';
import 'package:sailors/src/data/models/params/update_password_params.dart';
import 'package:sailors/src/data/models/params/update_profile_params.dart';
import '../../core/resources/data_state.dart';
import '../../data/models/ad_model.dart';
import '../../data/models/auth_model.dart';
import '../../data/models/params/confirm_phone_params.dart';
import '../../data/models/params/login_params.dart';
import '../../data/models/params/send_contact_us_params.dart';
import '../../data/models/params/support_params.dart';
import '../../data/models/user_model.dart';

abstract class AppRepository {
  Future<DataState<AuthModel>> login(LoginParams params);

  Future<DataState<AuthModel>> register(RegisterParams params);

  Future<DataState<UserModel>> sendOtpCode(String phone);

  Future<DataState<AuthModel>> confirmOtp(
    ConfirmPhoneParams confirmPhoneParams,
  );

  Future<DataState<void>> updatePassword(
    UpdatePasswordParams updatePasswordParams,
  );

  Future<DataState<List<AdModel>>> getCurrentAds();

  Future<DataState<List<AdModel>>> getPreviousAds();

  Future<DataState<UserModel>> updateProfile(
    UpdateProfileParams updateProfileParams,
  );

  Future<DataState<void>> contactUs(ContactUsParams params);

  Future<DataState<void>> sendSupport(SupportRequestParams params);

  Future<DataState<AdvertiseModel>> createAdvertisement(CreateAdvertiseParams params);

  Future<DataState<List<PackageModel>>> getAllPackages();

  Future<DataState<List<CategoryModel>>> getAllCategories();

}
