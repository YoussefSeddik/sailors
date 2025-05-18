class UserModel {
  final int? id;
  final String? name;
  final String? phone;
  final String? avatar;

  final int? is_active;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.avatar,
    required this.is_active
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      avatar: json['avatar'],
      is_active: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'avatar': avatar,
      'is_active': is_active
    };
  }
}
