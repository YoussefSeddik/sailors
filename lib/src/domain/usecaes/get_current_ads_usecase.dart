import '../../data/models/ad_model.dart';
import '../repositories/profile_repository.dart';

class GetCurrentAdsUseCase {
  final ProfileRepository repo;
  GetCurrentAdsUseCase(this.repo);

  Future<List<AdModel>> call() => repo.getCurrentAds();
}