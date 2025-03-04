import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:payansh/screens/home_screen.dart';
import 'package:payansh/screens/login_screen.dart';
import 'package:payansh/services/api_service.dart';
import '../utils/local_storage.dart';
import '../constants/app_constants.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
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
      Get.snackbar("Login Success", response["message"], snackPosition: SnackPosition.BOTTOM);
      String token = response["accessToken"];
      print("🔹 Saving Token: $token");

      // Save token based on "Remember Me"
      if (isRememberMe.value) {
        await LocalStorage.saveUserToken(token);
      }

      AppConstants.authToken = token;
      Get.offAll(() => HomeScreen());
    } else {
      Get.snackbar("Login Failed", response["message"], snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> checkLoginStatus() async {
    String? token = await LocalStorage.getUserToken();

    if (token != null && token.isNotEmpty) {
      AppConstants.authToken ??= token;
      print("Token in checkLoginStatus: $token");
      Get.offAll(() => HomeScreen());
    } else {
      print("User logged out");
      await Future.delayed(const Duration(milliseconds: 500));
      Get.offAll(() => LoginScreen());
    }
  }
}
