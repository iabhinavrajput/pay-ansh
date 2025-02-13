import 'dart:async';
import 'package:get/get.dart';
import 'package:payansh/routes/routes.dart';
import 'package:payansh/screens/enter_new_password.dart';
import 'package:payansh/screens/login_screen.dart';
import 'package:payansh/screens/reset_password.dart';
import 'package:payansh/services/api_service.dart';

class ForgotPasswordController extends GetxController {
  var isLoading = false.obs;
  var email = ''.obs;
  var otpCode = ''.obs;
  var resetToken = ''.obs; // ✅ Store resetToken for password reset
  var otpTimer = 60.obs;

  /// **Start OTP Timer**
  void startOtpTimer() {
    otpTimer.value = 60; 
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (otpTimer.value > 0) {
        otpTimer.value--;
      } else {
        timer.cancel();
        Get.snackbar("Error", "OTP Expired! Request a new OTP.");
      }
    });
  }

  /// **Step 1: Send Reset OTP**
  Future<void> sendResetOTP(String emailInput) async {
    isLoading.value = true;
    var response = await ApiService.forgotPassword(emailInput);
    isLoading.value = false;

    if (response["success"]) {
      email.value = emailInput;
      startOtpTimer(); // ✅ Start OTP countdown
      Get.to(() => ResetPasswordScreen()); // Navigate to OTP screen
    } else {
      Get.snackbar("Error", response["message"], snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// **Step 2: Verify OTP & Get Reset Token**
  Future<void> verifyOTP(String otp) async {
    isLoading.value = true;
    var response = await ApiService.verifyResetOTP(email.value, otp);
    isLoading.value = false;

    if (response["success"]) {
      resetToken.value = response["resetToken"]; // ✅ Store resetToken
      Get.to(() => EnterNewPasswordScreen()); // Navigate to password reset screen
    } else {
      Get.snackbar("Error", response["message"], snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// **Step 3: Reset Password**
  Future<void> resetPassword(String newPassword, String confirmPassword) async {
    isLoading.value = true;
    var response = await ApiService.resetPassword(resetToken.value, newPassword, confirmPassword);
    isLoading.value = false;

    if (response["success"]) {
      Get.offAll(() => LoginScreen()); // ✅ Redirect to Login on success
    } else {
      Get.snackbar("Error", response["message"], snackPosition: SnackPosition.BOTTOM);
    }
  }
}

