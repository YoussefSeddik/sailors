class CategoryModel {
  final int id;
  final String? name;
  final String? image;
  final int? isActive;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isActive,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      isActive: json['is_active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'is_active': isActive,
    };
  }
}
