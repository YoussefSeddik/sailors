abstract class OtpEvent {}

class OtpSubmitted extends OtpEvent {
  final String otp;
  OtpSubmitted(this.otp);
}

class OtpResendRequested extends OtpEvent {}

class OtpTick extends OtpEvent {}
