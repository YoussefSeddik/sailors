import '../../../core/bloc/base_state.dart';
import '../../../core/resources/data_state.dart';
import '../../../data/models/params/login_params.dart';
import '../../../domain/usecaes/app_usecase.dart';
import 'login_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, BaseState<void>> {
  final AppUseCases appUseCases;

  LoginBloc(this.appUseCases) : super(InitialState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
      LoginSubmitted event,
      Emitter<BaseState<void>> emit,
      ) async {
    emit(LoadingState());

    try {
      final result = await appUseCases.login(
        LoginParams(phone: event.phone, password: event.password),
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

