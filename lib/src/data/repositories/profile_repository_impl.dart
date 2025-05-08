import '../../domain/repositories/profile_repository.dart';
import '../datasources/remote/profile_api_service.dart';
import '../models/ad_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileApiService api;

  ProfileRepositoryImpl(this.api);

  @override
  Future<List<AdModel>> getCurrentAds() async {
    final response = await api.fetchAds(type: 'current');
    return (response as List).map((e) => AdModel.fromJson(e)).toList();
  }

  @override
  Future<List<AdModel>> getPreviousAds() async {
    final response = await api.fetchAds(type: 'past');
    return (response as List).map((e) => AdModel.fromJson(e)).toList();
  }
}
