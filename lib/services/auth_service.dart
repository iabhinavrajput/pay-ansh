import 'package:flutter/material.dart';
import 'package:payansh/utils/local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import '../screens/login_screen.dart';

class AuthService {
  static Future<void> logout(BuildContext context) async {
    try {
      await LocalStorage.clearTokens();
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      print('Logout Error: $e');
    }
  }
}
