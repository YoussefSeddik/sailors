class AdModel {
  final String id;
  final String imageUrl;
  final String title;
  final String statusText;
  final bool isExpired;

  AdModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.statusText,
    required this.isExpired,
  });

  factory AdModel.fromJson(Map<String, dynamic> json) => AdModel(
    id: json['id'],
    imageUrl: json['image'],
    title: json['title'],
    statusText: json['status'],
    isExpired: json['expired'] ?? false,
  );
}
