class ProfileApiService {
  Future<List<Map<String, dynamic>>> fetchAds({required String type}) async {
    // Replace with real API call
    return Future.delayed(
      const Duration(milliseconds: 500),
      () => [
        {
          'id': '1',
          'image': 'https://example.com/boat.jpg',
          'title': 'قارب أفراد بطول 26 قدماً (7.92)',
          'status': 'سينتهي بعد 5 أيام',
          'expired': type == 'past',
        },
      ],
    );
  }
}
