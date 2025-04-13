abstract class LoginEvent {}

class RegisterSubmitted extends LoginEvent {
  final String name;
  final String phone;
  final String password;

  RegisterSubmitted(this.name, this.phone, this.password);
}
