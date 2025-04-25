import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../core/bloc/base_state.dart';
import 'otp_event.dart';

class OtpBloc extends Bloc<OtpEvent, BaseState<void>> {
  int secondsRemaining = 0;
  Timer? _timer;

  OtpBloc() : super(InitialState()) {
    on<OtpSubmitted>(_onSubmit);
    on<OtpResendRequested>(_onResend);
    on<OtpTick>(_onTick);
  }

  Future<void> _onSubmit(
    OtpSubmitted event,
    Emitter<BaseState<void>> emit,
  ) async {
    emit(LoadingState());
    await Future.delayed(const Duration(seconds: 1)); // Simulate API call

    if (event.otp == "1234") {
      emit(SuccessState(null));
      secondsRemaining = 30;
      _startTimer();
    } else {
      emit(FailureState("Incorrect OTP"));
    }
  }

  Future<void> _onResend(
    OtpResendRequested event,
    Emitter<BaseState<void>> emit,
  ) async {
    secondsRemaining = 30;
    emit(InitialState());
  }

  void _onTick(OtpTick event, Emitter<BaseState<void>> emit) {
    emit(TickState(secondsRemaining)); // Rebuild UI
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

