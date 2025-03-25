import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/api_endpoints.dart';
import 'package:payansh/screens/home_screen.dart';
import 'package:payansh/screens/login_screen.dart';
import 'package:payansh/screens/delete_user_otp.dart';
import 'package:payansh/services/api_service.dart';
import '../utils/local_storage.dart';
import '../constants/app_constants.dart';
import 'package:http/http.dart' as http;
import '../utils/snackbar_util.dart'; // Import custom snackbar

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isPasswordVisible = false.obs; // Password visibility toggle

  static final FlutterSecureStorage storage = FlutterSecureStorage();

  static Future<String?> getAccessToken() async {
    return await storage.read(key: 'accessToken');
  }

  static Future<Map<String, String>> getHeaders() async {
    String? token = await getAccessToken();
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    var response = await ApiService.loginUser(email, password);
    isLoading.value = false;

    if (response["success"]) {
      showSnackbar(
        title: "Login Success",
        message: response["message"],
        isSuccess: true, // Green snackbar
      );

      String? checkToken = await LocalStorage.getUserToken();
      print("✅ Token Saved: $checkToken");

      Get.offAll(() => const HomeScreen());
    } else {
      showSnackbar(
        title: "Login Failed",
        message: response["message"],
        isSuccess: false, // Red snackbar
      );
    }
  }

  Future<void> logout() async {
    await LocalStorage.clearUserToken();
    AppConstants.authToken = null;
    AppConstants.refreshToken = null;
    Get.offAll(() => LoginScreen());

    showSnackbar(
      title: "Logged Out",
      message: "You have been logged out.",
      isSuccess: false, // Red snackbar for logout
    );
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

  static Future<void> deleteAccountInitiate(BuildContext context) async {
    final headers = await getHeaders();
    final response = await http
        .post(Uri.parse(ApiEndpoints.deleteAccountInitiate), headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        showSnackbar(
          title: data['status'],
          message: data['message'],
          isSuccess: true, // Green snackbar
        );
        Get.to(() => DeleteUserProfileOtp());
      }
    } else {
      final data = jsonDecode(response.body);
      showSnackbar(
        title: data['status'],
        message: data['message'],
        isSuccess: false,
      );
    }
  }

  Future<void> verifyDeleteAccountOtp(String otp) async {
    isLoading.value = true;
    final headers = await getHeaders();

    final response = await http.post(
      Uri.parse(ApiEndpoints.deleteAccountConfirm),
      headers: headers,
      body: jsonEncode({'otp': otp}),
    );

    isLoading.value = false;

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        showSnackbar(
          title: data['status'],
          message: data['message'],
          isSuccess: true,
        );
        await LocalStorage.clearUserToken();
        Get.offAllNamed('/login');
      }
    } else {
      final data = jsonDecode(response.body);

      showSnackbar(
        title: data['status'],
        message: data['message'],
        isSuccess: false, 
      );
    }
  }
}
