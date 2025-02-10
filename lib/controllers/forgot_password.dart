import 'dart:async';
import 'package:get/get.dart';
import 'package:payansh/screens/enter_new_password.dart';
import 'package:payansh/screens/login_screen.dart';
import 'package:payansh/screens/reset_password.dart';
import 'package:payansh/services/api_service.dart';

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
      Get.snackbar("Error", "OTP Expired! Request a new OTP.");
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
    Get.snackbar("Error", response["message"], snackPosition: SnackPosition.BOTTOM);
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
      Get.snackbar("Error", response["message"], snackPosition: SnackPosition.BOTTOM);
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
    Get.offAll(() => LoginScreen());
  } else {
    print("❌ Password Reset Failed: ${response["message"]}");
    Get.snackbar("Error", response["message"], snackPosition: SnackPosition.BOTTOM);
  }
}


   Future<void> verifyOTP(String otp) async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 2)); // Simulating API Call
    isLoading.value = false;

    otpCode.value = otp;  // ✅ Store the OTP before moving to the next screen

    Get.snackbar("Success", "OTP Verified", snackPosition: SnackPosition.BOTTOM);
    Get.to(() => EnterNewPasswordScreen());
  }
}

