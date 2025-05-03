abstract class ForgetPasswordEventEvent {}

class ForgetPassword extends ForgetPasswordEventEvent {
  final String phone;

  ForgetPassword(this.phone);
}
