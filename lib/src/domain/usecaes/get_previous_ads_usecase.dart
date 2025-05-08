import '../../data/models/ad_model.dart';
import '../repositories/profile_repository.dart';

class GetPreviousAdsUseCase {
  final ProfileRepository repo;
  GetPreviousAdsUseCase(this.repo);

  Future<List<AdModel>> call() => repo.getPreviousAds();
}