class AdvertiseTypeModel {
  final int id;
  final String? name;
  final String? type;

  AdvertiseTypeModel({
    required this.id,
    required this.name,
    required this.type,
  });

  factory AdvertiseTypeModel.fromJson(Map<String, dynamic> json) {
    return AdvertiseTypeModel(
      id: json['id'],
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'type': type};
  }
}
