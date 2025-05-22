import 'package:sailors/src/data/models/auth_model.dart';
import 'package:sailors/src/presentation/screens/register/register_event.dart';
import '../../../core/bloc/base_state.dart';
import '../../../core/resources/data_state.dart';
import '../../../data/models/params/register_params.dart';
import '../../../domain/usecaes/app_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, BaseState<void>> {
  final AppUseCases appUseCases;

  RegisterBloc(this.appUseCases) : super(InitialState()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(
      RegisterSubmitted event,
      Emitter<BaseState<void>> emit,
      ) async {
    emit(LoadingState());

    try {
      final result = await appUseCases.register(
        RegisterParams(
          name: event.name,
          phone: event.phone,
          password: event.password,
        ),
      );

      if (result is DataSuccess<AuthModel?>) {
        emit(SuccessState(null));
      } else {
        emit(FailureState(result.message ?? 'Unknown error'));
      }
    } catch (e) {
      emit(FailureState('Unexpected error: ${e.toString()}'));
    }
  }
}

