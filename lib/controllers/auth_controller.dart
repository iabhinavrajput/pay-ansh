import 'package:get/get.dart';
import 'package:payansh/screens/home_screen.dart';
import 'package:payansh/screens/login_screen.dart';
import 'package:payansh/services/api_service.dart';
import '../utils/local_storage.dart';

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
    Get.snackbar("Login Success", response["message"], snackPosition: SnackPosition.BOTTOM);
    String token = response["accessToken"];
    print("🔹 Saving Token: $token"); // Debugging statement

    await LocalStorage.saveUserToken(token); // Save token

    String? checkToken = await LocalStorage.getUserToken();
    print("✅ Token Saved: $checkToken"); // Verify storage

    Get.offAll(() => HomeScreen());
  } else {
    Get.snackbar("Login Failed", response["message"], snackPosition: SnackPosition.BOTTOM);
  }
}


  Future<void> checkLoginStatus() async {
    String? token = await LocalStorage.getUserToken();

    if (token != null && token.isNotEmpty) {
      // Navigate to home if token exists
      Get.offAll(() => HomeScreen());
    } else {
      // If no token, navigate to login
      Get.offAll(() => LoginScreen());
    }
  }
}