import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:payansh/constants/api_endpoints.dart';
import 'package:payansh/screens/common_otp.dart';
import 'package:payansh/utils/snackbar_util.dart';
import '../constants/app_constants.dart';

class EmailUpdateController extends GetxController {
  var isLoading = false.obs; // Observable loading state
  final TextEditingController _otpController = TextEditingController();

  Future<void> updateEmail(String newEmail) async {
    if (newEmail.isEmpty) {
      showSnackbar(
          title: "Error",
          message: "Please enter a valid email",
          isSuccess: false);
      return;
    }

    String? token = AppConstants.authToken;
    if (token == null) {
      showSnackbar(
          title: "Error",
          message: "Please try after some time",
          isSuccess: false);
      return;
    }

    final Uri url = Uri.parse(ApiEndpoints.emailUpdate);

    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "new_email": newEmail,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        String successMessage = responseData["message"] ??
            "Email updated successfully"; // ✅ Fix null issue
        showSnackbar(
            title: "Success", message: successMessage, isSuccess: true);

        Get.to(() => CommonOtpScreen(
              title: "OTP Verification",
              subtitle:
                  "We’ll send the OTP as a text message to your new email address.",
              imagePath: 'assets/gif/auth/otp.gif',
              onOtpSubmit: (otp) => _verifyOTP(
                  otp, newEmail), // Pass OTP and newEmail to function
              onResendOtp: () => updateEmail(newEmail), // Resend OTP
            ));

        // Get.to(() => VerifyEmailScreen(newEmail: newEmail, authToken: token));
      } else {
        print("responseData: $responseData"); // ✅ Debugging help
        String errorMessage = responseData["error"]; // ✅ Fix null issue
        print("erroe message  : $errorMessage"); // ✅ Debugging help
        showSnackbar(title: "Error", message: errorMessage, isSuccess: false);
      }
    } catch (error) {
      showSnackbar(
          title: "Error",
          message: "Something went wrong. Please try again.",
          isSuccess: false);
      print("API Error: $error"); // ✅ Debugging help
    }
  }

  Future<void> _verifyOTP(String otp, String newEmail) async {
    if (otp.isEmpty) {
      showSnackbar(
          title: "Error", message: "Please enter OTP", isSuccess: false);
      return;
    }

    final Uri url = Uri.parse(ApiEndpoints.verifyEmailUpdate);
    try {
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer ${AppConstants.authToken}",
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "new_email": newEmail,
          "otp": otp,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        showSnackbar(
            title: responseData["status"],
            message: responseData["message"],
            isSuccess: true);

        Get.offAllNamed("/home");
      } else {
        showSnackbar(
            title: responseData["status"],
            message: responseData["message"],
            isSuccess: false);
      }
    } catch (error) {
      showSnackbar(
          title: "Error", message: "Something went wrong", isSuccess: false);
      return;
    }
  }
}
