import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'local_storage_service.dart';

class SecureStorageService implements LocalStorageService {
  final FlutterSecureStorage _secureStorage;

  SecureStorageService(this._secureStorage);

  @override
  Future<void> saveModel<T>(
    String key,
    T model,
    Map<String, dynamic> Function(T) toJson,
  ) async {
    final jsonString = jsonEncode(toJson(model));
    await _secureStorage.write(key: key, value: jsonString);
  }

  @override
  Future<T?> getModelAsync<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    final jsonString = await _secureStorage.read(key: key);
    if (jsonString == null) return null;

    final jsonMap = jsonDecode(jsonString);
    return fromJson(jsonMap);
  }

  @override
  Future<void> remove(String key) async {
    await _secureStorage.delete(key: key);
  }
}
