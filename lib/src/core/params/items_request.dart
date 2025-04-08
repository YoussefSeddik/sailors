import '../utils/constants.dart';

class ItemsRequestParams {
  final String apiKey;
  final String country;

  const ItemsRequestParams({
    this.apiKey = kApiKey,
    this.country = 'us'
  });
}
