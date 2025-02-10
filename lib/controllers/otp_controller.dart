import 'dart:async';

import 'package:get/get.dart';
import 'package:payansh/services/api_service.dart';

class OtpController extends GetxController {
  var isLoading = false.obs;
  var otpTimer = 30.obs; // Default OTP expiry time in seconds


  void startOtpTimer() {
    otpTimer.value = 30; // Reset timer
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpTimer.value > 0) {
        otpTimer.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> verifyOtp(int userId, String otp) async {
    if (otp.isEmpty) {
      Get.snackbar("Error", "OTP cannot be empty",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;
    try {
      final response = await ApiService.verifySignupOTP(userId, otp);

      if (response["success"]) {
        Get.snackbar(
          "Success",
          response["message"],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.cardColor,
        );

        // Navigate to home screen or login screen after successful verification
        Get.offAllNamed('/home'); // Change '/home' to your actual home route
      } else {
        Get.snackbar(
          "Error",
          response["message"],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error,
          colorText: Get.theme.cardColor,
        );
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong. Try again.");
    } finally {
      isLoading.value = false;
    }
  }
}
