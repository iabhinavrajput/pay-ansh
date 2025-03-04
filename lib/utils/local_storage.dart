import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

class LocalStorage {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  // Save access token
  static Future<void> saveUserToken(String token) async {
    await _storage.write(key: AppConstants.authTokenKey, value: token);
  }

  // Get access token
  static Future<String?> getUserToken() async {
    return await _storage.read(key: AppConstants.authTokenKey);
  }

  // Clear access token
  static Future<void> clearUserToken() async {
    await _storage.delete(key: AppConstants.authTokenKey);
  }

  // Save refresh token
  static Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: AppConstants.refreshTokenKey, value: token);
  }

  // Get refresh token
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: AppConstants.refreshTokenKey);
  }

  // Clear refresh token
  static Future<void> clearRefreshToken() async {
    await _storage.delete(key: AppConstants.refreshTokenKey);
  }

  // Clear both tokens
  static Future<void> clearTokens() async {
    await _storage.delete(key: AppConstants.authTokenKey);
    await _storage.delete(key: AppConstants.refreshTokenKey);
  }
}
