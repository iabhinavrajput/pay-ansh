import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:payansh/constants/api_endpoints.dart';
import 'package:payansh/screens/otp_verification.dart';
import 'package:payansh/utils/snackbar_util.dart';

class SignupController extends GetxController {
  final Dio _dio = Dio();
  final isLoading = false.obs;
  var userId = 0.obs; // Store user ID

  Future<void> signup(
      String name, String email, String password, String phone) async {
    isLoading.value = true;
    try {
      final response = await _dio.post(
        "${ApiEndpoints.baseUrl}/signup",
        data: {
          "name": name,
          "email": email,
          "password": password,
          "phoneNumber": phone,
        },
      );

      if (response.statusCode == 201) {
        final responseData = response.data;
        userId.value = responseData["data"]["userId"]; // Store userId

        showSnackbar(title:
          "Success",message: 
          responseData['message'] ?? "Signup successful!", isSuccess: false
        );

        // Navigate to OTP Screen and pass userId
        Get.to(() => OtpVerification(userId: userId.value));
      } else {
        _showErrorPopup(
            response.data['message'] ?? "Signup failed. Try again.");
      }
    } catch (e) {
      _showErrorPopup("Something went wrong! Please try again.");
    } finally {
      isLoading.value = false;
    }
  }

  void _showErrorPopup(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
  }
}
