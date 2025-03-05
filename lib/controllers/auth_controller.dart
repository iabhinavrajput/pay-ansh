import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payansh/screens/home_screen.dart';
import 'package:payansh/screens/login_screen.dart';
import 'package:payansh/services/api_service.dart';
import '../utils/local_storage.dart';
import '../constants/app_constants.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isPasswordVisible = false.obs; // Password visibility toggle
  var isRememberMe = false.obs; // "Remember Me" state
  final GetStorage storage = GetStorage(); // GetStorage instance

  @override
  void onInit() {
    super.onInit();
    isRememberMe.value = storage.read('remember_me') ?? false;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe(bool value) {
    isRememberMe.value = value;
    storage.write('remember_me', value);
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    var response = await ApiService.loginUser(email, password);
    isLoading.value = false;

    if (response["success"]) {
      Get.snackbar("Login Success", response["message"],
          snackPosition: SnackPosition.BOTTOM);
      Get.offAll(() => HomeScreen());

      String accessToken = response["data"]["tokens"]["accessToken"];
      String refreshToken = response["data"]["tokens"]["refreshToken"];
      print("🔹 Saving Tokens: $accessToken, $refreshToken");

      // Save tokens
      await LocalStorage.saveUserToken(accessToken);
      await LocalStorage.saveRefreshToken(refreshToken);

      // Save token in local storage
      // await LocalStorage.saveUserToken(token);

      // Also assign token to AppConstants for global access
      AppConstants.authToken = accessToken;

      String? checkToken = await LocalStorage.getUserToken();
      print("✅ Token Saved: $checkToken"); // Verify storage

      if (isRememberMe.value) {
        await LocalStorage.saveUserToken(accessToken);
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
      Get.offAll(() => HomeScreen());
    } else {
      print("Now logged out");
      // If no token, navigate to login
      await Future.delayed(
          const Duration(milliseconds: 500)); // Smooth transition
      Get.offAll(() => LoginScreen());
    }
  }
}
