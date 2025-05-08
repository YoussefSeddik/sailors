import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:sailors/src/data/repositories/profile_repository_impl.dart';
import 'package:sailors/src/domain/usecaes/cofirm_phone_usecase.dart';
import 'package:sailors/src/domain/usecaes/register_usecase.dart';
import 'package:sailors/src/domain/usecaes/send_otp_usecase.dart';
import 'package:sailors/src/domain/usecaes/update_password_usecase.dart';
import 'package:sailors/src/presentation/screens/forget_password/forget_password_bloc.dart';
import 'package:sailors/src/presentation/screens/login/login_bloc.dart';
import 'package:sailors/src/presentation/screens/otp/otp_bloc.dart';
import 'package:sailors/src/presentation/screens/profile_screen/profile_ads_bloc.dart';
import 'package:sailors/src/presentation/screens/profile_screen/profile_bloc.dart';
import 'package:sailors/src/presentation/screens/register/register_bloc.dart';
import 'package:sailors/src/presentation/screens/update_password_screen/update_password_bloc.dart';
import 'core/caching/local_storage_service.dart';
import 'core/caching/local_storage_service_impl.dart';
import 'data/datasources/remote/auth_api_service.dart';
import 'data/datasources/remote/profile_api_service.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/repositories/profile_repository.dart';
import 'domain/usecaes/get_current_ads_usecase.dart';
import 'domain/usecaes/get_previous_ads_usecase.dart';
import 'domain/usecaes/login_usecase.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  injector.registerSingleton<LocalStorageService>(SecureStorageService(injector<FlutterSecureStorage>()));

  // Dio client
  injector.registerSingleton<Dio>(Dio());

  // Dependencies
  injector.registerSingleton<AuthApiService>(AuthApiService(injector()));
  injector.registerSingleton<ProfileApiService>(ProfileApiService());
  injector.registerSingleton<AuthRepository>(AuthRepositoryImpl(injector()));
  injector.registerSingleton<ProfileRepository>(ProfileRepositoryImpl(injector()));

  // UseCases
  injector.registerSingleton<LoginUseCase>(LoginUseCase(injector(), injector()));
  injector.registerSingleton<RegisterUseCase>(RegisterUseCase(injector()));
  injector.registerSingleton<ConfirmPhoneUseCase>(ConfirmPhoneUseCase(injector(), injector()));
  injector.registerSingleton<SendOtpUseCase>(SendOtpUseCase(injector()));
  injector.registerSingleton<UpdatePasswordUseCase>(UpdatePasswordUseCase(injector()));
  injector.registerSingleton<GetCurrentAdsUseCase>(GetCurrentAdsUseCase(injector()));
  injector.registerSingleton<GetPreviousAdsUseCase>(GetPreviousAdsUseCase(injector()));

  // Blocs
  injector.registerFactory<LoginBloc>(() => LoginBloc(injector()));
  injector.registerFactory<RegisterBloc>(() => RegisterBloc(injector()));
  injector.registerFactory<OtpBloc>(() => OtpBloc(injector(), injector()));
  injector.registerFactory<ForgetPasswordBloc>(() => ForgetPasswordBloc(injector()));
  injector.registerFactory<UpdatePasswordBloc>(() => UpdatePasswordBloc(injector()));
  injector.registerFactory<ProfileBloc>(() => ProfileBloc());
  injector.registerFactory<ProfileAdsBloc>(() => ProfileAdsBloc(injector(), injector()));
}
