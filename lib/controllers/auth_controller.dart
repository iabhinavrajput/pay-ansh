import 'package:get/get.dart';
import 'package:payansh/screens/home_screen.dart';
import 'package:payansh/screens/login_screen.dart';
import 'package:payansh/screens/recharge_bills.dart';
import 'package:payansh/services/api_service.dart';
import '../utils/local_storage.dart';
import 'package:payansh/screens/recharge_bills.dart';

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
      Get.snackbar("Login Success", response["message"],
          snackPosition: SnackPosition.BOTTOM);
      String token = response["accessToken"];
      print("🔹 Saving Token: $token"); // Debugging statement

      await LocalStorage.saveUserToken(token); // Save token

      String? checkToken = await LocalStorage.getUserToken();
      print("✅ Token Saved: $checkToken"); // Verify storage

      Get.offAll(() =>  RechargeBillPage());
    } else {
      Get.snackbar("Login Failed", response["message"],
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> checkLoginStatus() async {
    String? token = await LocalStorage.getUserToken();

    if (token != null && token.isNotEmpty) {
      print("This is token inside checkLoginStatus: ${token}");
      // Navigate to home if token exists
      Get.offAll(() =>  HomeScreen());
    } else {
      print("Now logged out");
      // If no token, navigate to login
        await Future.delayed(const Duration(milliseconds: 500)); // Small delay for smooth transition

      Get.offAll(() => LoginScreen());
    }
  }
}
