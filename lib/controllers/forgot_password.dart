import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/routes/routes.dart';
import 'package:payansh/screens/enter_new_password.dart';
import 'package:payansh/screens/login_screen.dart';
import 'package:payansh/screens/reset_password.dart';
import 'package:payansh/services/api_service.dart';
import 'package:payansh/utils/snackbar_util.dart';

class ForgotPasswordController extends GetxController {
  var isLoading = false.obs;
  var email = ''.obs;
  var otpCode = ''.obs;
  var otpTimer = 60.obs;
  var isSignupOtp = false.obs;
  var userId = 0.obs; // Store user ID for signup OTP verification
    var autoReadOtp = false.obs;


  void startOtpTimer() {
  otpTimer.value = 60; // Set OTP expiry time (in seconds)
  Timer.periodic(Duration(seconds: 1), (timer) {
    if (otpTimer.value > 0) {
      otpTimer.value--;
    } else {
      timer.cancel();
      showSnackbar(title:"Error", message:"OTP Expired! Request a new OTP.",isSuccess: false);
    }
  });
}

  Future<void> sendResetOTP(String emailInput) async {
  isLoading.value = true;
  var response = await ApiService.forgotPassword(emailInput);
  isLoading.value = false;

  if (response["success"]) {
    email.value = emailInput;
    otpCode.value = response["otp"] ?? "";

    startOtpTimer();  // ✅ Start OTP countdown timer

    Get.to(() => ResetPasswordScreen());
  } else {
    showSnackbar(title: "Error", message: response["message"], isSuccess: false);
  }
}

  Future<void> sendSignupOTP(int userIdInput) async {
    isLoading.value = true;
    var response = await ApiService.verifySignupOTP(userIdInput, otpCode.value);
    isLoading.value = false;

    if (response["success"]) {
      userId.value = userIdInput; // Store userId
      otpCode.value = response["otp"] ?? "";
      isSignupOtp.value = true; // This is for signup

      startOtpTimer();
      Get.to(() => ResetPasswordScreen());
    } else {
      showSnackbar(title: "Error", message: response["message"], isSuccess: false);
    }
  }

  void toggleAutoRead() {
    autoReadOtp.value = !autoReadOtp.value;
  }

  Future<void> resetPassword(String email, String otp, String newPassword, String confirmPassword) async {
  isLoading.value = true;

  print("📧 Email (Reset Request): $email");
  print("🔢 OTP Sent to API: $otp");  // 🔹 Debugging purpose
  print("🔑 New Password: $newPassword");

  var response = await ApiService.resetPassword(email, otp, newPassword, confirmPassword);
  
  isLoading.value = false;

  if (response["success"]) {
    print("✅ Password Reset Successfully");
    Get.offAll(() => AppRoutes.login);
  } else {
    print("❌ Password Reset Failed: ${response["message"]}");
    showSnackbar(title: "Error", message: response["message"], isSuccess: false);
  }
}


   Future<void> verifyOTP(String otp) async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2)); // Simulating API Call
    isLoading.value = false;

    otpCode.value = otp;  // ✅ Store the OTP before moving to the next screen

    showSnackbar(title: "Success", message: "OTP Verified", isSuccess: true);
    Get.to(() => EnterNewPasswordScreen());
  }
}

