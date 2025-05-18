abstract class OtpEvent {}

class OtpSubmitted extends OtpEvent {
  final String otp;
  final String phone;

  OtpSubmitted(this.otp, this.phone);
}

class StartTimer extends OtpEvent {}

class OtpResendRequested extends OtpEvent {
  final String phone;

  OtpResendRequested(this.phone);
}