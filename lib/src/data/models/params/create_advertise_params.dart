import 'dart:io';

class CreateAdvertiseParams {
  final String name;
  final String details;
  final String categoryId;
  final String packageId;
  final String advertisementTypeId;
  final String type;
  final String status;
  final String phone;
  final String whatsapp;
  final String adPrice;
  final String coupon;
  final List<File> images;

  CreateAdvertiseParams({
    required this.name,
    required this.details,
    required this.categoryId,
    required this.packageId,
    required this.advertisementTypeId,
    required this.type,
    required this.status,
    required this.phone,
    required this.whatsapp,
    required this.adPrice,
    required this.coupon,
    required this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'details': details,
      'category_id': categoryId,
      'package_id': packageId,
      'advertisement_type_id': advertisementTypeId,
      'type': type,
      'status': status,
      'phone': phone,
      'whatsapp': whatsapp,
      'ad_price': adPrice,
      'coupon': coupon,
    };
  }
}

enum AdvertiseStatus { new_, old }

enum AdvertiseType { normal, premium }

extension AdvertisementStatusExt on AdvertiseStatus {
  String get value => this == AdvertiseStatus.new_ ? 'new' : 'old';
}

extension AdvertisementTypeExt on AdvertiseType {
  String get value => this == AdvertiseType.normal ? 'normal' : 'premium';
}
