import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/controllers/auth_controller.dart';
import 'package:payansh/widgets/gradient_text.dart';
import 'package:payansh/widgets/gradient_button.dart';

class DeleteUserProfileOtp extends StatefulWidget {
  @override
  _DeleteUserProfileOtpState createState() => _DeleteUserProfileOtpState();
}

class _DeleteUserProfileOtpState extends State<DeleteUserProfileOtp> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  int _focusedIndex = -1; // To track which field is active

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      _focusNodes[i].addListener(() {
        setState(() {
          _focusedIndex = _focusNodes[i].hasFocus ? i : -1;
        });
      });
    }
  }

  void _submitOtp() async {
    String otp = _controllers.map((controller) => controller.text).join();
    final AuthController authController = Get.find<AuthController>();

    if (otp.length == 4) {
      await authController.verifyDeleteAccountOtp(otp);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the complete OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.dynamicWidth(context, 0.13)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            const Text(
              "Account Deletion",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "We’ll send the OTP to your registered\ne-mail ID",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            Image.asset(
              'assets/icon/forget.png',
              width: Dimensions.dynamicWidth(context, 0.3),
            ),
            const SizedBox(height: 30),

            /// OTP Input Fields in a Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                bool isFocused = _focusedIndex == index;
                return SizedBox(
                  width: 50,
                  child: RawKeyboardListener(
                    focusNode: FocusNode(),
                    onKey: (event) {
                      if (event is RawKeyDownEvent &&
                          event.logicalKey == LogicalKeyboardKey.backspace &&
                          _controllers[index].text.isEmpty) {
                        if (index > 0) {
                          _focusNodes[index - 1].requestFocus();
                          _controllers[index - 1].clear();
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: isFocused ? Colors.transparent : Colors.grey,
                          width: 0.5,
                        ),
                        gradient: isFocused
                            ? const LinearGradient(
                                colors: [AppColors.gradientStart, AppColors.gradientEnd],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              )
                            : null,
                      ),
                      padding: const EdgeInsets.all(1),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          decoration: const InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              if (index < 3) {
                                _focusNodes[index + 1].requestFocus();
                              } else {
                                _focusNodes[index].unfocus();
                              }
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 40),
            GradientButton(
              text: "Verify OTP",
              onPressed: _submitOtp,
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                await AuthController.deleteAccountInitiate(context);
              },
              child: const GradientText(
                'Resend OTP ?',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
