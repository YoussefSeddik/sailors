import 'package:sailors/src/data/models/package_model.dart';
import 'package:sailors/src/data/models/user_model.dart';

import 'advertise_type_model.dart';
import 'category_model.dart';

class AdvertiseModel {
  final int? id;
  final UserModel? user;
  final CategoryModel? category;
  final PackageModel? package;
  final AdvertiseTypeModel? advertisementType;
  final String? coupon;
  final String? price;
  final String? couponDiscount;
  final num? priceAfterCoupon;
  final String? paymentStatus;
  final String? name;
  final String? details;
  final String? adPrice;
  final String? phone;
  final String? whatsapp;
  final String? type;
  final String? status;
  final String? startAt;
  final String? expireAt;
  final List<AdvertisementImage>? images;
  final String? createdAt;
  final String? expiredAt;

  AdvertiseModel({
    required this.id,
    required this.user,
    required this.category,
    required this.package,
    required this.advertisementType,
    required this.coupon,
    required this.price,
    required this.couponDiscount,
    required this.priceAfterCoupon,
    required this.paymentStatus,
    required this.name,
    required this.details,
    required this.adPrice,
    required this.phone,
    required this.whatsapp,
    required this.type,
    required this.status,
    required this.startAt,
    required this.expireAt,
    required this.images,
    required this.createdAt,
    required this.expiredAt,
  });

  factory AdvertiseModel.fromJson(Map<String, dynamic> json) {
    return AdvertiseModel(
      id: json['id'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      category: json['category'] != null ? CategoryModel.fromJson(json['category']) : null,
      package: json['package'] != null ? PackageModel.fromJson(json['package']) : null,
      advertisementType: json['advertisement_type'] != null
          ? AdvertiseTypeModel.fromJson(json['advertisement_type'])
          : null,
      coupon: json['coupon'],
      price: json['price'],
      couponDiscount: json['coupon_discount'],
      priceAfterCoupon: json['price_after_coupon'],
      paymentStatus: json['payment_status'],
      name: json['name'],
      details: json['details'],
      adPrice: json['ad_price'],
      phone: json['phone'],
      whatsapp: json['whatsapp'],
      type: json['type'],
      status: json['status'],
      startAt: json['start_at'],
      expireAt: json['expire_at'],
      images: json['images'] != null
            ? (json['images'] as List?)
            ?.map((img) => AdvertisementImage.fromJson(img))
            .toList(): [],
      createdAt: json['created_at'],
      expiredAt: json['expired_at']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'category': category?.toJson(),
      'package': package?.toJson(),
      'advertisement_type': advertisementType?.toJson(),
      'coupon': coupon,
      'price': price,
      'coupon_discount': couponDiscount,
      'price_after_coupon': priceAfterCoupon,
      'payment_status': paymentStatus,
      'name': name,
      'details': details,
      'ad_price': adPrice,
      'phone': phone,
      'whatsapp': whatsapp,
      'type': type,
      'status': status,
      'start_at': startAt,
      'expire_at': expireAt,
      'images': images?.map((e) => e.toJson()).toList(),
      'created_at': createdAt,
      'expired_at': expireAt
    };
  }
}


class AdvertisementImage {
  final int? id;
  final String? image;

  AdvertisementImage({required this.id, required this.image});

  factory AdvertisementImage.fromJson(Map<String, dynamic> json) {
    return AdvertisementImage(id: json['id'], image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'image': image};
  }
}
extension AdvertiseModelExtensions on AdvertiseModel {
  bool get isExpired {
    if (expiredAt == null) return false;
    try {
      final expiry = DateTime.parse(expiredAt!);
      return expiry.isBefore(DateTime.now());
    } catch (_) {
      return false;
    }
  }

  int get daysUntilExpiration {
    if (expireAt == null) return 0;
    try {
      final expiry = DateTime.parse(expireAt!);
      final now = DateTime.now();
      final diff = expiry.difference(now).inDays;
      return diff >= 0 ? diff : 0;
    } catch (_) {
      return 0;
    }
  }
}