import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/auth_model.dart';
import '../../models/user_model.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST('/login')
  Future<HttpResponse<AuthModel>> login(
    @Field('phone') String phone,
    @Field('password') String password,
  );

  @POST('/login')
  Future<HttpResponse<AuthModel>> register(
    @Field('name') String name,
    @Field('phone') String phone,
    @Field('password') String password,
  );

  @POST('/sendOtpCode')
  Future<HttpResponse<void>> sendOtpCode(@Field('phone') String phone);

  @POST('/confirmOtp')
  Future<HttpResponse<AuthModel>> confirmOtp(
    @Field('phone') String phone,
    @Field('otp_code') String otp,
  );

  @POST('/updatePassword')
  Future<HttpResponse<UserModel>> updatePassword(
    @Field('password') String password,
  );
}
