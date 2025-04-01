import 'package:flutter/material.dart';
import 'package:payansh/components/custom_app_bar_kyc.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/widgets/gradient_button.dart';

class PhoneVerification extends StatefulWidget {
  final String value;
  const PhoneVerification({super.key, required this.value});

  @override
  State<PhoneVerification> createState() => _PhoneVerificationState();
}

class _PhoneVerificationState extends State<PhoneVerification> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.value; // Set old value in text field
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarKYC(
          title: "Mobile Verification",
          description:
              "Enter the mobile number where\nyou want to get the OTP"),
      body: Padding(
        padding:  EdgeInsets.all(Dimensions.dynamicWidth(context, 0.05)),
        child: Column(
          children: [
                        SizedBox(height: Dimensions.dynamicHeight(context, 0.03),),

            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Contact Number",
                labelStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  foreground: Paint()
                    ..shader = const LinearGradient(
                      colors: [
                        AppColors.gradientStart,
                        AppColors.gradientEnd
                      ], // Gradient colors
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 30.0)),
                ),
                contentPadding: const EdgeInsets.only(
                  left: 20,
                ),
            
                // Icon (if provided)
                suffixIcon: Icons.phone != null
                    ? Padding(
                        padding:
                            const EdgeInsets.only(right: 10), // Add right padding
                        child: Icon(Icons.phone, color: Color(0xffD9D9DA)),
                      )
                    : null,
            
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xffD9D9DA), // Border color
                    width: 0.8, // Force a thin border
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xffD9D9DA), // Same border color
                    width: 0.8, // Thin border width when not focused
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Colors.blue, // Highlight color on focus
                    width: 1, // Slightly thicker on focus
                  ),
                ),
              ),
            ),
            SizedBox(height: Dimensions.dynamicHeight(context, 0.03),),
            GradientButton(text: 
            "Verify", onPressed: () {})
          ],
        ),
      ),
    );
  }
}
