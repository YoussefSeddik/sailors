import 'package:sailors/src/data/models/advertise_model.dart';
import 'package:sailors/src/data/models/ad_model.dart';

AdModel mapToAdModel(AdvertiseModel ad) {
  return AdModel(
    id: ad.id?.toString() ?? '',
    imageUrl: ad.images?.firstOrNull?.image ?? '',
    title: ad.name ?? '',
    statusText: ad.status ?? '',
    isExpired: ad.isExpired,
  );
}
