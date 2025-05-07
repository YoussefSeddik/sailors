import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../core/utils/api_response.dart';
import '../../../core/utils/constants.dart';
import '../../models/auth_model.dart';
import '../../models/params/register_params.dart';
import '../../models/user_model.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

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
}
