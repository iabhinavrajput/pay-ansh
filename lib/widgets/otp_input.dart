import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/widgets/button_loader.dart';
import 'package:payansh/widgets/gradient_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpInput extends StatelessWidget {
  final Function(String) onOtpEntered;
  final RxInt otpTimer;
  final VoidCallback? onResend;
  final RxBool isLoading;
  final VoidCallback onVerify;

  OtpInput({
    super.key,
    required this.onOtpEntered,
    required this.otpTimer,
    required this.isLoading,
    required this.onVerify,
    this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),

        // OTP Input Field
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: PinCodeTextField(
            length: 4,
            obscureText: false,
            animationType: AnimationType.fade,
            keyboardType: TextInputType.number,
            textStyle:
                const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(10),
              fieldHeight: 50,
              fieldWidth: 50,
              activeFillColor: Colors.transparent,
              inactiveFillColor: Colors.transparent,
              selectedFillColor: Colors.transparent,
              activeColor: AppColors.gradientStart,
              inactiveColor: Colors.grey.withOpacity(0.3),
              selectedColor: AppColors.gradientStart,
            ),
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            onChanged: (value) {},
            appContext: context,
            showCursor: false,
            onCompleted: (otp) {
              onOtpEntered(otp);
            },
          ),
        ),

        const SizedBox(height: 20),

        // Verify Button
        Obx(() => isLoading.value
            ? const ButtonLoader()
            : GradientButton(
                text: "Verify OTP",
                onPressed: onVerify,
              )),
      ],
    );
  }
}
