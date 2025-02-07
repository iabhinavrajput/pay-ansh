import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:payansh/constants/api_endpoints.dart';
import 'package:payansh/screens/otp_verification.dart';

class SignupController extends GetxController {
  final Dio _dio = Dio();
  final isLoading = false.obs;

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

        // Show success message as a bottom pop-up
        Get.snackbar(
          "Success",
          responseData['message'] ?? "Signup successful!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );

        // Navigate to OTP Screen after 2 seconds
        // await Future.delayed(const Duration(seconds: 2));
        Get.to(() => const OtpVerification());
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
