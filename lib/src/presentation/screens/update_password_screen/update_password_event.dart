abstract class UpdatePasswordEvent {}

class SubmitPassword extends UpdatePasswordEvent {
  final String password;
  final String confirmedPassword;

  SubmitPassword(this.password, this.confirmedPassword);
}
