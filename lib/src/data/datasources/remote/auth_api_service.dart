import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/user_model.dart';

part 'auth_api_service.g.dart';

@RestApi()
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST('/login')
  Future<HttpResponse<UserModel>> login(
    @Field('phone') String phone,
    @Field('password') String password,
  );

  @POST('/login')
  Future<HttpResponse<UserModel>> register(
    @Field('name') String name,
    @Field('phone') String phone,
    @Field('password') String password,
  );
}
