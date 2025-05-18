class SendOtpParams {
  final String phone;

  const SendOtpParams({required this.phone});

  Map<String, dynamic> toJson() {
    return {'phone': phone};
  }
}
