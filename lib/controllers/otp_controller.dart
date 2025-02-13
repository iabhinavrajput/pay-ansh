import 'dart:async';

import 'package:get/get.dart';
import 'package:payansh/routes/routes.dart';
import 'package:payansh/services/api_service.dart';
import 'package:payansh/utils/snackbar_util.dart';

class OtpController extends GetxController {
  var isLoading = false.obs;
  var otpTimer = 30.obs; // Default OTP expiry time in seconds

  void startOtpTimer() {
    otpTimer.value = 300; // Reset timer
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
      showSnackbar(
          title: "Error", message: "OTP cannot be empty", isSuccess: false);
      return;
    }

    isLoading.value = true;
    try {
      final response = await ApiService.verifySignupOTP(userId, otp);

      if (response["success"]) {
        showSnackbar(
            title: "Success", message: response["message"], isSuccess: true);

        // Navigate to home screen or login screen after successful verification
        Get.offAllNamed(
            AppRoutes.home); // Change '/home' to your actual home route
      } else {
        showSnackbar(
            title: "Error", message: response["message"], isSuccess: false);
      }
    } catch (e) {
      showSnackbar(
          title: "Error",
          message: "Something went wrong. Try again.",
          isSuccess: false);
    } finally {
      isLoading.value = false;
    }
  }
}
