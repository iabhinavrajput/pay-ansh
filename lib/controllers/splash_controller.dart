import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:payansh/screens/login_screen.dart'; // Replace with your actual home screen

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(milliseconds: 800), () {
      Get.off(() => LoginScreen());
    });
  }
}
