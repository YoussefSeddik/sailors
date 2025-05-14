import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/utils/api_response.dart';
import '../../../core/utils/constants.dart';
import '../../models/auth_model.dart';
import '../../models/params/register_params.dart';
import '../../models/user_model.dart';

part 'app_api_service.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class AppApiService {
  factory AppApiService(Dio dio, {String baseUrl}) = _AppApiService;

  @POST('/login')
  Future<HttpResponse<ApiResponse<AuthModel>>> login(
    @Field('phone') String phone,
    @Field('password') String password,
  );

  @POST('/register')
  Future<HttpResponse<ApiResponse<AuthModel>>> register(
    @Body() RegisterParams body,
  );

  @POST('/sendOtpCode')
  Future<HttpResponse<ApiResponse<void>>> sendOtpCode(@Field('phone') String phone);

  @POST('/verify-otp')
  Future<HttpResponse<ApiResponse<AuthModel>>> confirmOtp(
    @Field('phone') String phone,
    @Field('otp_code') String otp,
  );

  @POST('/updatePassword')
  Future<HttpResponse<ApiResponse<UserModel>>> updatePassword(
    @Field('password') String password,
  );

  @POST('/fetchAds')
  Future<HttpResponse<ApiResponse<UserModel>>> fetchAds(@Field('password') String password,);

}
