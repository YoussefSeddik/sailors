import 'dart:io';

class UpdateProfileParams {
  final File? avatar;
  final String name;
  final String phone;

  const UpdateProfileParams({
    required this.avatar,
    required this.name,
    required this.phone,
  });
}
