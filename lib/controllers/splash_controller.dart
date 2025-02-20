import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:payansh/screens/login_screen.dart'; // Replace with your actual home screen
=======
import 'package:payansh/controllers/auth_controller.dart';
import 'package:payansh/screens/home_screen.dart';
import 'package:payansh/screens/login_screen.dart';
>>>>>>> 599fbbc77c56b9709db8e2140bb74c0887680054

class SplashController extends GetxController {
  final AuthController authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(milliseconds: 1500), () async {
      await authController.checkLoginStatus();
    });
  }
}
