import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:sailors/src/data/models/auth_model.dart';
import '../../../core/bloc/base_state.dart';
import '../../../core/resources/data_state.dart';
import '../../../data/models/params/confirm_phone_params.dart';
import '../../../domain/usecaes/app_usecase.dart';
import 'otp_event.dart';

class OtpBloc extends Bloc<OtpEvent, BaseState<void>> {
  int secondsRemaining = 0;
  Timer? _timer;

  final AppUseCases appUseCases;

  OtpBloc(this.appUseCases) : super(InitialState()) {
    on<OtpSubmitted>(_onSubmit);
    on<OtpResendRequested>(_onResend);
    on<OtpTick>(_onTick);
  }

  Future<void> _onSubmit(
    OtpSubmitted event,
    Emitter<BaseState<void>> emit,
  ) async {
    emit(LoadingState());

    final result = await appUseCases.confirmPhone(
      ConfirmPhoneParams(phone: event.phone, otp: event.otp),
    );

    if (result is DataSuccess) {
      emit(SuccessState<AuthModel?>(result.data));
    } else {
      emit(FailureState(result.error?.message ?? "OTP verification failed"));
    }
  }

  Future<void> _onResend(
    OtpResendRequested event,
    Emitter<BaseState<void>> emit,
  ) async {
    emit(LoadingState());
    final result = await appUseCases.sendOtp(event.phone);
    if (result is DataSuccess) {
      secondsRemaining = 30;
      emit(InitialState());
      _startTimer();
    } else {
      emit(FailureState(result.error?.message ?? "Failed to resend OTP"));
    }
  }

  void _onTick(OtpTick event, Emitter<BaseState<void>> emit) {
    emit(TickState(secondsRemaining));
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining == 0) {
        timer.cancel();
      } else {
        secondsRemaining--;
        add(OtpTick());
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

class TickState<T> extends BaseState<T> {
  int secondsRemaining = 0;

  TickState(this.secondsRemaining);
}
