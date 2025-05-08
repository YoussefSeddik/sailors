import '../../data/models/ad_model.dart';

abstract class ProfileRepository {
  Future<List<AdModel>> getCurrentAds();

  Future<List<AdModel>> getPreviousAds();
}
