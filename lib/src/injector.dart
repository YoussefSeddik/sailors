import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:sailors/src/data/datasources/remote/app_api_service.dart';
import 'package:sailors/src/domain/repositories/app_repository.dart';
import 'package:sailors/src/presentation/screens/forget_password/forget_password_bloc.dart';
import 'package:sailors/src/presentation/screens/login/login_bloc.dart';
import 'package:sailors/src/presentation/screens/otp/otp_bloc.dart';
import 'package:sailors/src/presentation/screens/profile_screen/profile_ads_bloc.dart';
import 'package:sailors/src/presentation/screens/profile_screen/profile_bloc.dart';
import 'package:sailors/src/presentation/screens/register/register_bloc.dart';
import 'package:sailors/src/presentation/screens/settings/settings_bloc.dart';
import 'package:sailors/src/presentation/screens/update_password_screen/update_password_bloc.dart';
import 'config/localization/app_language.dart';
import 'core/caching/local_storage_service.dart';
import 'core/caching/local_storage_service_impl.dart';
import 'core/utils/locale_provider.dart';
import 'data/repositories/app_repository_impl.dart';
import 'domain/usecaes/app_usecase.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  injector.registerSingleton<FlutterSecureStorage>(
    const FlutterSecureStorage(),
  );
  injector.registerSingleton<LocalStorageService>(
    SecureStorageService(injector<FlutterSecureStorage>()),
  );

  injector.registerSingleton<LocaleProvider>(
    LocaleProvider(getLocale: () => AppLanguage().appLocal),
  );

  // Dio client
  injector.registerSingleton<Dio>(Dio());
  injector.registerSingleton<AppApiService>(AppApiService(injector()));

  // Dependencies
  injector.registerSingleton<AppRepository>(AppRepositoryImpl(injector()));

  // UseCases
  injector.registerSingleton<AppUseCases>(AppUseCases(injector(), injector()));

  // Blocs
  injector.registerFactory<LoginBloc>(() => LoginBloc(injector()));
  injector.registerFactory<RegisterBloc>(() => RegisterBloc(injector()));
  injector.registerFactory<OtpBloc>(() => OtpBloc(injector()));
  injector.registerFactory<ForgetPasswordBloc>(() => ForgetPasswordBloc(injector()),);
  injector.registerFactory<UpdatePasswordBloc>(() => UpdatePasswordBloc(injector()),);
  injector.registerFactory<ProfileBloc>(() => ProfileBloc());
  injector.registerFactory<ProfileAdsBloc>(() => ProfileAdsBloc(injector()));
  injector.registerFactory<SettingsBloc>(() => SettingsBloc(injector(), injector()));
}
