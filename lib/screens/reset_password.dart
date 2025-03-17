import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/widgets/gradient_text.dart';
import '../controllers/forgot_password.dart';
import '../widgets/gradient_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email; // Accept email from previous screen

  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final ForgotPasswordController forgotPasswordController = Get.find();
  final List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> otpFocusNodes =
      List.generate(4, (index) => FocusNode());

  final RxInt focusedIndex = (-1).obs; // Track the focused input field

  final RxInt countdown = 180.obs; // 3-minute countdown
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    startTimer();

    // Listen to focus changes and update focusedIndex
    for (int i = 0; i < otpFocusNodes.length; i++) {
      otpFocusNodes[i].addListener(() {
        if (otpFocusNodes[i].hasFocus) {
          focusedIndex.value = i;
        } else if (focusedIndex.value == i) {
          focusedIndex.value = -1;
        }
      });
    }
  }

  void startTimer() {
    _timer?.cancel(); // Cancel existing timer if any
    countdown.value = 180; // Reset to 180 seconds
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown.value > 0) {
        countdown.value--;
      } else {
        timer.cancel();
      }
    });
  }

  void resendOTP() {
    forgotPasswordController.sendResetOTP(widget.email); // Resend OTP
    startTimer(); // Restart timer
  }

  @override
  void dispose() {
    _timer?.cancel();

    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in otpFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: Dimensions.dynamicWidth(context, 0.14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            const Text("Forget Password",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text(
                "We’ll send the OTP your registered\ne-mail Id",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 30),

            // CircleAvatar(
            //   radius: 40,
            //   backgroundColor: Colors.blue.shade50,
            //   child:
            //       const Icon(Icons.lock_outline, size: 40, color: Colors.blue),
            // ),

            Image.asset(
              'assets/icon/Forget-icon-animation1.png',
              width: Dimensions.dynamicWidth(context, 0.3),
            ),
            const SizedBox(height: 30),

            // OTP Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisAlignment: MainAxisAlignment.start,

              children: List.generate(4, (index) {
                return Obx(() {
                  bool isFocused = focusedIndex.value == index;

                  return Stack(alignment: Alignment.center, children: [
                    // Gradient Border
                    Container(
                      width: 60,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.transparent, // Make border transparent
                        ),
                        gradient: isFocused
                            ? LinearGradient(
                                colors: [
                                  AppColors.gradientStart,
                                  AppColors.gradientEnd
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : null,
                      ),
                    ),

                    // Inner TextField Container with Transparent Background
                    Container(
                      width: 59, // Slightly smaller than the outer container
                      height: 49,
                      decoration: BoxDecoration(
                        color: Colors.white, // Ensure background is white
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: isFocused
                              ? Colors.transparent
                              : Colors.grey, // Grey for unfocused
                          width: 0.5,
                        ),
                      ),
                      child: TextField(
                        controller: otpControllers[index],
                        focusNode: otpFocusNodes[index],
                        cursorColor: AppColors.gradientStart,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        decoration: const InputDecoration(
                          counterText: "",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 3) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      ),
                    )
                  ]);
                });
              }),
            ),
            const SizedBox(height: 5),

            Obx(() {
              return countdown.value > 0
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "Resend: ",
                              style: TextStyle(
                                color: AppColors.greytextColors,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${countdown.value}s",
                              style: TextStyle(
                                color: AppColors.gradientEnd,
                                fontSize: 12,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 40),

                        // Verify Button
                        Obx(() => forgotPasswordController.isLoading.value
                            ? const CircularProgressIndicator()
                            : GradientButton(
                                text: "Verify OTP",
                                onPressed: () {
                                  String otp = otpControllers
                                      .map((controller) => controller.text)
                                      .join();
                                  forgotPasswordController.verifyOTP(otp);
                                },
                              )),
                      ],
                    )
                  : Column(
                      children: [
                        const SizedBox(height: 40),
                        Obx(() => forgotPasswordController.isLoading.value
                            ? const CircularProgressIndicator()
                            : GradientButton(
                                text: "Verify OTP",
                                onPressed: () {
                                  String otp = otpControllers
                                      .map((controller) => controller.text)
                                      .join();
                                  forgotPasswordController.verifyOTP(otp);
                                },
                              )),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: resendOTP,
                          child: GradientText(
                            'Resend OTP ?',
                            style: const TextStyle(fontSize: 17),
                          ),
                        )
                      ],
                    );
            }),
          ],
        ),
      ),
    );
  }
}
