import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/bloc/base_state.dart';
import 'otp_event.dart';

class OtpBloc extends Bloc<OtpEvent, BaseState<void>> {
  int secondsRemaining = 30;
  Timer? _timer;

  OtpBloc() : super(InitialState()) {
    on<OtpSubmitted>(_onSubmit);
    on<OtpResendRequested>(_onResend);
    _startTimer();
  }

  Future<void> _onSubmit(OtpSubmitted event, Emitter emit) async {
    emit(LoadingState());
    await Future.delayed(const Duration(seconds: 1)); // simulate API call
    if (event.otp == "1234") {
      emit(SuccessState(null));
    } else {
      emit(FailureState("Incorrect OTP"));
    }
  }

  Future<void> _onResend(OtpResendRequested event, Emitter emit) async {
    secondsRemaining = 30;
    emit(InitialState());
    _startTimer();
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
