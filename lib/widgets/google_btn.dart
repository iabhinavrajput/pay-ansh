import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/screens/home_screen.dart';
import 'package:payansh/services/google_sign_in_service.dart';

class GoogleBtn extends StatefulWidget {
  const GoogleBtn({super.key});

  @override
  State<GoogleBtn> createState() => _GoogleBtnState();
}

class _GoogleBtnState extends State<GoogleBtn> {
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    final user = await GoogleSignInService.signInWithGoogle();

    setState(() {
      _isLoading = false;
    });

    if (user['success']) {
      Get.to(() => const HomeScreen());
      print("Login successful: $user");
    } else {
      print("Login failed: ${user['message']}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Platform.isIOS ? null : _handleGoogleSignIn,
      child: Container(
        width: double.infinity,
        height: Dimensions.dynamicHeight(context, 0.06),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.gradientEnd,
            width: 1,
          ),
        ),
        child: _isLoading
            ? const Center(
                child: SpinKitRotatingCircle(
  color: Colors.blue,
  size: 25.0,
),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Platform.isIOS
                      ? SvgPicture.asset(
                          "assets/icon/Apple_logo_black.svg",
                          width: Dimensions.dynamicWidth(context, 0.06),
                        )
                      : Image.asset(
                          "assets/icon/google.png",
                          width: Dimensions.dynamicWidth(context, 0.08),
                        ),
                  SizedBox(width: Dimensions.dynamicWidth(context, 0.03)),
                  const Text(
                    "Login with Google",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
      ),
    );
  }
}
