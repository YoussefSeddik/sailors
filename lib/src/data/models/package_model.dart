import 'package:sailors/src/data/models/advertise_type_model.dart';


class PackageModel {
  final int id;
  final int? countedNumber;
  final String? price;
  final AdvertiseTypeModel? advertisementType;

  PackageModel({
    required this.id,
    required this.countedNumber,
    required this.price,
    required this.advertisementType,
  });

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    return PackageModel(
      id: json['id'],
      countedNumber: json['counted_number'],
      price: json['price'],
      advertisementType: AdvertiseTypeModel.fromJson(json['advertisement_type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'counted_number': countedNumber,
      'price': price,
      'advertisement_type': advertisementType?.toJson(),
    };
  }
}
