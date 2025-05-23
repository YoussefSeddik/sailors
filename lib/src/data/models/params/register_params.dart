class RegisterParams {
  final String name;
  final String phone;
  final String password;

  const RegisterParams({
    required this.name,
    required this.phone,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {'name': name, 'phone': phone, 'password': password};
  }
}
