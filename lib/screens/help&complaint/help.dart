import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:payansh/components/custom_app_bar_kyc.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/widgets/gradient_button.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<Help> createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarKYC(
          title: "Help Guideline",
          description: 'Please follow each step for KYC\nverification'),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.dynamicWidth(context, 0.05)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Dimensions.dynamicHeight(context, 0.005),
            ),
            Text(
              "KYC",
              style: TTextTheme.lightTextTheme.titleMedium,
            ),
            SizedBox(
              height: Dimensions.dynamicHeight(context, 0.01),
            ),
            Text(
              "•  Complete your KYC by Aadhar Number.",
              style: TTextTheme.lightTextTheme.bodyMedium,
            ),
            SizedBox(
              height: Dimensions.dynamicHeight(context, 0.01),
            ),
            Container(
              width: Dimensions.dynamicWidth(context, 0.33),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Color(0x334686C5),
                borderRadius: BorderRadius.circular(6),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withOpacity(0.1),
                //   ),
                // ],
              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/kyc/ri_eye-fill.svg'),
                  const SizedBox(width: 10),
                  const Text(
                    "View Steps",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: Color(0xff0B263F),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.dynamicHeight(context, 0.04),
            ),
            Text(
              "•  Complete your KYC PAN Number",
              style: TTextTheme.lightTextTheme.bodyMedium,
            ),
            SizedBox(
              height: Dimensions.dynamicHeight(context, 0.01),
            ),
            Container(
              width: Dimensions.dynamicWidth(context, 0.33),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Color(0x334686C5),
                borderRadius: BorderRadius.circular(6),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withOpacity(0.1),
                //   ),
                // ],
              ),
              child: Row(
                children: [
                  SvgPicture.asset('assets/kyc/ri_eye-fill.svg'),
                  const SizedBox(width: 10),
                  const Text(
                    "View Steps",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      color: Color(0xff0B263F),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.dynamicHeight(context, 0.02),
            ),
            Text(
              "Need More Help ?",
              style: TTextTheme.lightTextTheme.bodyMedium,
            ),
             SizedBox(
              height: Dimensions.dynamicHeight(context, 0.02),
            ),
            GradientButton(text: "Raise a complaint?", onPressed: () {})
          ],
        ),
      ),
    );
  }
}
