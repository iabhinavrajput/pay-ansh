import 'package:get/get.dart';
import 'package:payansh/screens/home_screen.dart';
import 'package:payansh/screens/login_screen.dart';
import 'package:payansh/services/api_service.dart';
import '../utils/local_storage.dart';
import '../constants/app_constants.dart';

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

  print("Login API Response: $response"); // Debug the full response

  if (response["success"]) {
    Get.snackbar("Login Success", response["message"],
        snackPosition: SnackPosition.BOTTOM);

    // Extract tokens from nested 'data' object
    var data = response["data"];
    String? accessToken = data?["accessToken"];
    String? refreshToken = data?["refreshToken"];

    if (accessToken != null && refreshToken != null) {
      print("🔹 Saving Access Token: $accessToken");
      print("🔹 Saving Refresh Token: $refreshToken");

      await LocalStorage.saveUserToken(accessToken);
      await LocalStorage.saveRefreshToken(refreshToken);

      AppConstants.authToken = accessToken;
      AppConstants.refreshToken = refreshToken;

      Get.offAll(() => HomeScreen());
    } else {
      Get.snackbar("Error", "Tokens are missing from response.",
          snackPosition: SnackPosition.BOTTOM);
      print("❌ Error: Tokens are null.");
    }
  } else {
    Get.snackbar("Login Failed", response["message"],
        snackPosition: SnackPosition.BOTTOM);
  }
}


  Future<void> checkLoginStatus() async {
    String? token = await LocalStorage.getUserToken();

    if (token != null && token.isNotEmpty) {
      // Optionally update the global token if not already set
      AppConstants.authToken ??= token;
      print("This is token inside checkLoginStatus: $token");

      // Navigate to home if token exists
      Get.offAll(() => const HomeScreen());
    } else {
      print("Now logged out");
      // If no token, navigate to login
      await Future.delayed(const Duration(milliseconds: 500)); // Smooth transition
      Get.offAll(() => LoginScreen());
    }
  }
}
