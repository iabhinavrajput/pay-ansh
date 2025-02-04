import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';
import '../constants/app_colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatelessWidget {
  final SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo
            Image.asset(
              'assets/images/logo.png',
              width: screenWidth * 0.6,
            ),
            // SizedBox(height: screenHeight * 0.05),

            // Loading Indicator
            // SpinKitCircle(
            //   color: Colors.black,
            //   size: 50.0,
            // ),
          ],
        ),
      ),
    );
  }
}
