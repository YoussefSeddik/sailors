import 'package:sailors/src/data/models/auth_model.dart';
import 'package:sailors/src/data/models/params/update_password_params.dart';
import 'package:sailors/src/presentation/screens/update_password_screen/update_password_event.dart';
import '../../../core/bloc/base_state.dart';
import '../../../core/caching/local_storage_service.dart';
import '../../../core/resources/data_state.dart';
import '../../../domain/usecaes/app_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdatePasswordBloc extends Bloc<UpdatePasswordEvent, BaseState<void>> {
  final AppUseCases _appUseCases;
  final LocalStorageService _localStorageService;

  UpdatePasswordBloc(this._appUseCases, this._localStorageService)
      : super(InitialState()) {
    on<SubmitPassword>(_onSubmitPassword);
  }

  Future<void> _onSubmitPassword(
      SubmitPassword event,
      Emitter<BaseState<void>> emit,
      ) async {
    emit(LoadingState());

    try {
      final user = await _localStorageService.getModelAsync<AuthModel>(
        AuthModel.storageKey,
        AuthModel.fromJson,
      );

      if (user == null) {
        emit(FailureState('User not found'));
        return;
      }

      final result = await _appUseCases.updatePassword(
        UpdatePasswordParams(
          phone: user.user.phone,
          password: event.password,
          password_confirmation: event.confirmedPassword,
        ),
      );

      if (result is DataSuccess) {
        emit(SuccessState(null));
      } else {
        emit(FailureState(result.message ?? 'Unknown error'));
      }
    } catch (e) {
      emit(FailureState('Unexpected error: ${e.toString()}'));
    }
  }
}

