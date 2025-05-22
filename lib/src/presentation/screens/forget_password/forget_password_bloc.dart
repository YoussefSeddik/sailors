import 'package:sailors/src/data/models/user_model.dart';
import 'package:sailors/src/domain/usecaes/app_usecase.dart';
import 'package:sailors/src/presentation/screens/forget_password/forget_password_event.dart';
import '../../../core/bloc/base_state.dart';
import '../../../core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordBloc extends Bloc<ForgetPassword, BaseState<UserModel>> {
  final AppUseCases appUseCases;

  ForgetPasswordBloc(this.appUseCases) : super(InitialState()) {
    on<ForgetPassword>(_onForgetPassword);
  }

  Future<void> _onForgetPassword(
      ForgetPassword event,
      Emitter<BaseState<UserModel>> emit,
      ) async {
    emit(LoadingState());
    try {
      final result = await appUseCases.sendOtp(event.phone);
      if (result is DataSuccess<UserModel>) {
        emit(SuccessState(result.data));
      } else {
        emit(FailureState(result.message ?? 'Unknown error'));
      }
    } catch (e) {
      emit(FailureState('Unexpected error: ${e.toString()}'));
    }
  }
}

