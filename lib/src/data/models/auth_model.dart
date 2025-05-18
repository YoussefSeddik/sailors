import 'package:sailors/src/data/models/user_model.dart';

class AuthModel {
  final String token;
  UserModel user;
  static const storageKey = 'auth_model';


  AuthModel({required this.token, required this.user});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['token'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'token': token, 'user': user.toJson()};
  }
}
