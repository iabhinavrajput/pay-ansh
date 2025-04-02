import 'package:flutter/material.dart';
import 'package:payansh/components/custom_app_bar_kyc.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';

class ViewSteps extends StatefulWidget {
  const ViewSteps({super.key});

  @override
  State<ViewSteps> createState() => _ViewStepsState();
}

class _ViewStepsState extends State<ViewSteps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarKYC(
          title: "View KYC Steps",
          description: "Please follow each step for KYC\nverification"),
      body: Padding(
        padding: EdgeInsets.all(
          Dimensions.dynamicWidth(context, 0.05),
        ),
        child: 
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.005),
              ),
              Text(
                "1. Below image you will see the KYC Status ",
                style: TTextTheme.lightTextTheme.bodyMedium,
              ),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.005),
              ),
              Text(
                "Profile > KYC Status",
                style: TTextTheme.lightTextTheme.labelMedium,
              ),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.008),
              ),
              Image.asset(
                "assets/step/step1.png",
                width: Dimensions.dynamicWidth(context, 0.7),
              ),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.03),
              ),
              Text(
                "2. Click on Proceed Button to complete your KYC process",
                style: TTextTheme.lightTextTheme.bodyMedium,
              ),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.01),
              ),
             
              Image.asset(
                "assets/step/step2.png",
                width: Dimensions.dynamicWidth(context, 0.5),
              ),
                SizedBox(
                height: Dimensions.dynamicHeight(context, 0.03),
              ),
              Text(
                "3. Enter Your Aadhar Number",
                style: TTextTheme.lightTextTheme.bodyMedium,
              ),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.01),
              ),
             
              Image.asset(
                "assets/step/step3.png",
                width: Dimensions.dynamicWidth(context, 0.7),
              ),
                SizedBox(
                height: Dimensions.dynamicHeight(context, 0.03),
              ),
              Text(
                "4. Enter OTP  received by Udyog Aadhar OTP Verification. Click on Verify",
                style: TTextTheme.lightTextTheme.bodyMedium,
              ),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.01),
              ),
             
              Image.asset(
                "assets/step/step4.png",
                width: Dimensions.dynamicWidth(context, 0.6),
              ),
                SizedBox(
                height: Dimensions.dynamicHeight(context, 0.03),
              ),
              Text(
                "5. Enter Your PAN Number",
                style: TTextTheme.lightTextTheme.bodyMedium,
              ),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.01),
              ),
             
              Image.asset(
                "assets/step/step5.png",
                width: Dimensions.dynamicWidth(context, 0.7),
              ),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.03),
              ),
            ]
          )
          
        ),
      ),
    );
  }
}
