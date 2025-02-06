import 'package:get/get.dart';
import 'package:payansh/screens/reset_password.dart';
import '../screens/login_screen.dart';
import '../services/api_service.dart';

class ForgotPasswordController extends GetxController {
  var isLoading = false.obs;
  var email = ''.obs;

  Future<void> sendResetOTP(String emailInput) async {
    isLoading.value = true;
    var response = await ApiService.forgotPassword(emailInput);
    isLoading.value = false;

    if (response["success"]) {
      email.value = emailInput;
      Get.to(() => ResetPasswordScreen());
    } else {
      Get.snackbar("Error", response["message"], snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> resetPassword(String otp, String newPassword, String confirmPassword) async {
    isLoading.value = true;
    var response = await ApiService.resetPassword(email.value, otp, newPassword, confirmPassword);
    isLoading.value = false;

    if (response["success"]) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.snackbar("Error", response["message"], snackPosition: SnackPosition.BOTTOM);
    }
  }
}
