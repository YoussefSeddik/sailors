class UserModel {
  final String name;
  final String phone;
  final String token;

  UserModel({required this.name, required this.phone, required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      phone: json['phone'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'phone': phone, 'token': token};
  }
}
