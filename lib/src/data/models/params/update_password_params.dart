class UpdatePasswordParams {
  final String? phone;
  final String password;
  final String password_confirmation;

  const UpdatePasswordParams({
    required this.phone,
    required this.password,
    required this.password_confirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'password': password,
      'password_confirmation': password_confirmation,
    };
  }
}
