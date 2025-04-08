import 'item_model.dart';

class ItemsResponseModel {
  final String status;
  final int totalResults;
  final List<ItemModel> items;

  ItemsResponseModel({
    required this.status,
    required this.totalResults,
    required this.items,
  });

  factory ItemsResponseModel.fromJson(Map<String, dynamic> json) {
    return ItemsResponseModel(
      status: json['status'] as String,
      totalResults: json['totalResults'] as int,
      items: List<ItemModel>.from(
        (json['articles'] as List<dynamic>).map(
          (e) => ItemModel.fromJson(e as Map<String, dynamic>),
        ),
      ),
    );
  }
}
