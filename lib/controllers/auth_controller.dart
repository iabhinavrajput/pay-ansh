import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:payansh/screens/home_screen.dart';
import 'package:payansh/screens/login_screen.dart';
import 'package:payansh/services/api_service.dart';
import '../utils/local_storage.dart';
import '../constants/app_constants.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isPasswordVisible = false.obs; // Password visibility toggle

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    var response = await ApiService.loginUser(email, password);
    isLoading.value = false;

    if (response["success"]) {
      Get.snackbar("Login Success", response["message"],
          snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.green);

      String? checkToken = await LocalStorage.getUserToken();
      print("✅ Token Saved: $checkToken");

      Get.offAll(() => HomeScreen());
    } else {
      Get.snackbar("Login Failed", response["message"],
          snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.red);
    }
  }

  Future<void> logout() async {
    await LocalStorage.clearUserToken();
    AppConstants.authToken = null;
    Get.offAll(() => LoginScreen());
    Get.snackbar("Logged Out", "You have been logged out.",
        snackPosition: SnackPosition.BOTTOM);
  }

  Future<void> checkLoginStatus() async {
    String? token = await LocalStorage.getUserToken();

    if (token != null && token.isNotEmpty) {
      AppConstants.authToken ??= token;
      print("This is token inside checkLoginStatus: $token");
      Get.offAll(() => HomeScreen());
    } else {
      print("User not logged in, redirecting to login...");
      await Future.delayed(const Duration(milliseconds: 500));
      Get.offAll(() => LoginScreen());
    }
  }
}
