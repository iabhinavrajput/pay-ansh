import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:payansh/screens/login_screen.dart';

class AuthService {
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  static Future<void> logout(BuildContext context) async {
    // Clear secure token
    await _secureStorage.delete(key: 'user_token');

    // Clear SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Remove all previous routes and go to LoginScreen
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }
}
