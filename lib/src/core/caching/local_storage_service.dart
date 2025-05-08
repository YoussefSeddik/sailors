abstract class LocalStorageService {
  Future<void> saveModel<T>(
    String key,
    T model,
    Map<String, dynamic> Function(T) toJson,
  );

  Future<T?> getModelAsync<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson,
  );

  Future<void> remove(String key);
}
