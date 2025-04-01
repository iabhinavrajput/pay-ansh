import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/screens/home_screen.dart';
import 'package:payansh/services/google_sign_in_service.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';

class GoogleBtn extends StatefulWidget {
  final Function(bool)? onLoadingStateChanged; // Optional callback

  const GoogleBtn({super.key, this.onLoadingStateChanged});

  @override
  _GoogleBtnState createState() => _GoogleBtnState();
}

class _GoogleBtnState extends State<GoogleBtn> {
  bool _isLoading = false;

  Future<void> _handleGoogleSignIn() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });
    widget.onLoadingStateChanged?.call(true); // Notify parent if needed

    final user = await GoogleSignInService.signInWithGoogle();

    if (user['success']) {
      Get.to(() => const HomeScreen())?.then((_) {
        setState(() {
          _isLoading = false;
        });
        widget.onLoadingStateChanged?.call(false);
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      widget.onLoadingStateChanged?.call(false);
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

          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _isLoading ? AppColors.gradientStart : AppColors.gradientEnd, // Change border color when loading
            width: 1,
          ),
        ),

        child: Center(
          child: _isLoading
              ? const SpinKitSquareCircle(
                  color: AppColors.gradientStart,
                  size: 40,
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
                    Text(
                      Platform.isIOS ? "Login with Apple" : "Login with Google",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
