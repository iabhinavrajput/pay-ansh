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

      if (response.statusCode == 200) {
        final responseData = response.data;
        Get.defaultDialog(
          title: "Success",
          middleText: responseData['message'] ?? "Signup successful!",
          textConfirm: "OK",
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.back(); // Close the dialog
            Get.to(() => const OtpVerification());
          },
        );
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
    Get.defaultDialog(
      title: "Error",
      middleText: message,
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      onConfirm: () => Get.back(),
    );
  }
}
