import 'package:flutter/material.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/theme/custom_themes/text_field_theme.dart';
import 'package:payansh/theme/custom_themes/checkbox_theme.dart';
import 'package:payansh/widgets/custom_text_field.dart';
import 'package:payansh/widgets/gradient_button.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isChecked = false;
  TextEditingController mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Text(
              "SIGN UP WITH",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            Image.asset("assets/images/logo.png", height: 30),
            const SizedBox(height: 30),
            Text(
              "Let’s Connect Your Mobile Number",
              style: TextStyle(fontSize: 20, color: AppColors.greytextColors),
            ),
            const SizedBox(height: 30),
            // Use custom text field widget here
            CustomTextField(
              controller: mobileNumberController,
              hintText: "Enter Your Mobile Number",
              keyboardType: TextInputType.phone,
              icon:  Icons.phone,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                  shape: TCheckboxTheme.lightCheckboxTheme.shape,
                ),
                const Text("I agree to ",style: TextStyle(color: AppColors.greytextColors),),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Terms & Conditions",
                    style: TextStyle(
                        color: AppColors.gradientStart, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
                         GradientButton(text: "Continue", onPressed: () {}),

          ],
        ),
      ),
    );
  }
}
