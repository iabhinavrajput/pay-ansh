import 'package:get/get.dart';
import 'package:payansh/controllers/auth_controller.dart';
import 'package:payansh/screens/home_screen.dart';
import 'package:payansh/screens/login_screen.dart';

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
