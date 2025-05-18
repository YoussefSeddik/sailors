import 'package:sailors/src/data/models/auth_model.dart';
import 'package:sailors/src/data/models/params/update_password_params.dart';
import 'package:sailors/src/presentation/screens/update_password_screen/update_password_event.dart';

import '../../../core/bloc/base_state.dart';
import '../../../core/bloc/bloc_with_state.dart';
import '../../../core/caching/local_storage_service.dart';
import '../../../core/resources/data_state.dart';
import '../../../domain/usecaes/app_usecase.dart';

class UpdatePasswordBloc
    extends BlocWithState<UpdatePasswordEvent, BaseState<void>> {
  final AppUseCases _appUseCases;
  final LocalStorageService _localStorageService;

  UpdatePasswordBloc(this._appUseCases, this._localStorageService)
    : super(InitialState()) {
    on<SubmitPassword>((event, emit) async {
      await emit.forEach(
        runBlocProcess(() async* {
          emit(LoadingState());
          final user = await _localStorageService.getModelAsync(
            AuthModel.storageKey,
            AuthModel.fromJson,
          );
          DataState<void>? result;
          if (user != null) {
            result = await _appUseCases.updatePassword(
              UpdatePasswordParams(
                phone: user.user.phone,
                password: event.password,
                password_confirmation: event.confirmedPassword,
              ),
            );
          }
          if (result is DataSuccess) {
            yield SuccessState(null);
          } else {
            yield FailureState(result?.message ?? 'Unknown error');
          }
        }),
        onData: (s) => s,
      );
    });
  }
}
