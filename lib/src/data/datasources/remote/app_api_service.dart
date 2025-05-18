import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../core/utils/api_response.dart';
import '../../../core/utils/constants.dart';
import '../../models/auth_model.dart';
import '../../models/params/register_params.dart';
import '../../models/params/send_contact_us_params.dart';
import '../../models/params/send_otp_params.dart';
import '../../models/params/support_params.dart';
import '../../models/params/update_password_params.dart';
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

  @POST('/resend-otp')
  Future<HttpResponse<ApiResponse<UserModel>>> sendOtpCode(
    @Body() SendOtpParams params,
  );

  @POST('/verify-otp')
  Future<HttpResponse<ApiResponse<AuthModel>>> confirmOtp(
    @Field('phone') String phone,
    @Field('otp_code') String otp,
  );

  @POST('/reset-password')
  Future<HttpResponse<ApiResponse<UserModel>>> updatePassword(
    @Body() UpdatePasswordParams params,
  );

  @POST('/fetchAds')
  Future<HttpResponse<ApiResponse<UserModel>>> fetchAds(
    @Field('password') String password,
  );

  @POST('/update-profile')
  @MultiPart()
  Future<HttpResponse<ApiResponse<UserModel>>> updateProfile(
    @Part(name: "name") String name,
    @Part(name: "phone") String phone,
    @Part(name: "avatar") File? avatar,
  );

  @POST('/send-contact')
  Future<HttpResponse<ApiResponse<void>>> contactUs(
    @Body() ContactUsParams params,
  );

  @POST('/send-support')
  Future<HttpResponse<ApiResponse<void>>> sendSupport(
    @Body() SupportRequestParams params,
  );
}
