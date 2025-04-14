abstract class RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {
  final String name;
  final String phone;
  final String password;

  RegisterSubmitted(this.name, this.phone, this.password);
}
