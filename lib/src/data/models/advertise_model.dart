class AdvertiseModel {
  final int? id;
  final int? userId;
  final String? categoryId;
  final String? packageId;
  final String? advertisementTypeId;
  final int? couponId;
  final String? price;
  final String? couponDiscount;
  final String? coupon;
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

  AdvertiseModel({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.packageId,
    required this.advertisementTypeId,
    required this.couponId,
    required this.price,
    required this.couponDiscount,
    required this.coupon,
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
  });

  factory AdvertiseModel.fromJson(Map<String, dynamic> json) {
    return AdvertiseModel(
      id: json['id'],
      userId: json['user_id'],
      categoryId: json['category_id'],
      packageId: json['package_id'],
      advertisementTypeId: json['advertisement_type_id'],
      couponId: json['coupon_id'],
      price: json['price'],
      couponDiscount: json['coupon_discount'],
      coupon: json['coupon'],
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
          ? (json['images'] as List)
          .map((img) => AdvertisementImage.fromJson(img))
          .toList()
          : [],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'category_id': categoryId,
      'package_id': packageId,
      'advertisement_type_id': advertisementTypeId,
      'coupon_id': couponId,
      'price': price,
      'coupon_discount': couponDiscount,
      'coupon': coupon,
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
