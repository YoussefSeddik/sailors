import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sailors/src/domain/usecaes/register_usecase.dart';
import 'package:sailors/src/presentation/screens/login/login_bloc.dart';
import 'package:sailors/src/presentation/screens/otp/otp_bloc.dart';
import 'package:sailors/src/presentation/screens/register/register_bloc.dart';
import 'data/datasources/remote/auth_api_service.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'domain/usecaes/login_usecase.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio client
  injector.registerSingleton<Dio>(Dio());

  // Dependencies
  injector.registerSingleton<AuthApiService>(AuthApiService(injector()));
  injector.registerSingleton<AuthRepository>(AuthRepositoryImpl(injector()));

  // UseCases
  injector.registerSingleton<LoginUseCase>(LoginUseCase(injector()));
  injector.registerSingleton<RegisterUseCase>(RegisterUseCase(injector()));

  // Blocs
  injector.registerFactory<LoginBloc>(() => LoginBloc(injector()));
  injector.registerFactory<RegisterBloc>(() => RegisterBloc(injector()));
  injector.registerFactory<OtpBloc>(() => OtpBloc());
}
