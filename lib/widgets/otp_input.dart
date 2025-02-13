import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/widgets/gradient_button.dart';

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

  final List<TextEditingController> otpControllers =
      List.generate(4, (index) => TextEditingController());
  final List<FocusNode> otpFocusNodes =
      List.generate(4, (index) => FocusNode());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 30),

        // OTP Input Fields
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(4, (index) {
            return Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: otpControllers[index],
                focusNode: otpFocusNodes[index],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                maxLength: 1,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
            );
          }),
        ),

        const SizedBox(height: 20),

        // Resend OTP Timer
        Obx(() => Text(
              "OTP expires in: ${otpTimer.value}s",
              style: const TextStyle(color: Colors.red),
            )),

        const SizedBox(height: 20),

        // Verify Button
        Obx(() => isLoading.value
            ? const CircularProgressIndicator()
            : GradientButton(
                text: "Verify OTP",
                onPressed: () {
                  String otp = otpControllers
                      .map((controller) => controller.text)
                      .join();
                  onOtpEntered(otp);
                  onVerify();
                },
              )),
      ],
    );
  }
}
