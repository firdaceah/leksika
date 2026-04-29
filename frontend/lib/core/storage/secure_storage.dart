import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:leksika/core/constants/app_constants.dart';

class SecureStorage {
  SecureStorage(this.storage);

  final FlutterSecureStorage storage;

  Future<void> saveToken(String token) async {
    await storage.write(key: AppConstants.tokenKey, value: token);
  }

  Future<String?> readToken() async {
    return storage.read(key: AppConstants.tokenKey);
  }

  Future<void> clearToken() async {
    await storage.delete(key: AppConstants.tokenKey);
  }
}
