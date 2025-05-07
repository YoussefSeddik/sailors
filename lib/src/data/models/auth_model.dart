import 'package:json_annotation/json_annotation.dart';
import 'package:sailors/src/data/models/user_model.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthModel {
  final String token;
  final UserModel user;

  AuthModel({required this.token, required this.user});

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}
