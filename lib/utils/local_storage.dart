import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<void> saveUserToken(String token) async {
    await _storage.write(key: 'user_token', value: token);
  }

  static Future<String?> getUserToken() async {
    return await _storage.read(key: 'user_token');
  }

  static Future<void> clearUserToken() async {
    await _storage.delete(key: 'user_token');
  }
}
