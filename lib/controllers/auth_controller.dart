import 'package:get/get.dart';
import 'package:payansh/screens/home_screen.dart';
import 'package:payansh/screens/login_screen.dart';
import 'package:payansh/services/api_service.dart';
import '../utils/local_storage.dart';
import '../constants/app_constants.dart';
import '../utils/snackbar_util.dart'; // Import custom snackbar

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isPasswordVisible = false.obs; // Password visibility toggle

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    var response = await ApiService.loginUser(email, password);
    isLoading.value = false;

    if (response["success"]) {
      showSnackbar(
        title: "Login Success",
        message: response["message"],
        isSuccess: true, // Green snackbar
      );

      String? checkToken = await LocalStorage.getUserToken();
      print("✅ Token Saved: $checkToken");

      Get.offAll(() => const HomeScreen());
    } else {
      showSnackbar(
        title: "Login Failed",
        message: response["message"],
        isSuccess: false, // Red snackbar
      );
    }
  }

  Future<void> logout() async {
    await LocalStorage.clearUserToken();
    AppConstants.authToken = null;
    Get.offAll(() => LoginScreen());

    showSnackbar(
      title: "Logged Out",
      message: "You have been logged out.",
      isSuccess: false, // Red snackbar for logout
    );
  }

  Future<void> checkLoginStatus() async {
    String? token = await LocalStorage.getUserToken();

    if (token != null && token.isNotEmpty) {
      AppConstants.authToken ??= token;
      print("This is token inside checkLoginStatus: $token");
      Get.offAll(() => HomeScreen());
    } else {
      print("User not logged in, redirecting to login...");
      await Future.delayed(const Duration(milliseconds: 500));
      Get.offAll(() => LoginScreen());
    }
  }
}
