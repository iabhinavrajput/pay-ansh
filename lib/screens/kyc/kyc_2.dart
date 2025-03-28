import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:payansh/components/custom_app_bar_kyc.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:payansh/controllers/kyc_controller_aadhar.dart';
import 'package:payansh/screens/kyc/kyc_3.dart';
import 'package:payansh/screens/kyc/kyc_4.dart';
import 'package:payansh/controllers/kyc_controller_pan.dart';
import 'package:payansh/services/api_service.dart';
import 'package:payansh/utils/snackbar_util.dart';

class KycTwo extends StatelessWidget {
  const KycTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarKYC(
        title: "Upload Documents",
        description:
            "Please note that you can proceed with KYC\nthrough Aadhar Number or PAN Number",
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            GestureDetector(
              child: _buildKycOption(
                title: "KYC By Aadhar",
                imagePath: "assets/kyc/aadhar.png",
              ),
              onTap: () async {
                final KycControllerAadhar kycController = Get.put(KycControllerAadhar());

                // Fetch user profile
                Map<String, dynamic>? userProfile =
                    await ApiService.getUserProfile();

                if (userProfile == null) {
                  print("No user profile found.");
                  return;
                }

                // Extract and trim values safely
                String? email = userProfile['email']?.trim();
                String? name = userProfile['name']?.trim();

                if (email == null ||
                    email.isEmpty ||
                    name == null ||
                    name.isEmpty) {
                  print("Error: Email or Name is missing.");
                  return;
                }

                // Directly submit the KYC form
                kycController.submitKycForm(
                  customerIdentifier: email,
                  customerName: name,
                );

                print("✅ Name: $name");
                print("✅ E-Mail: $email");
              },
            ),
            const SizedBox(height: 20),
            GestureDetector(
              child: _buildKycOption(
                title: "KYC By PAN",
                imagePath: "assets/kyc/pan.png",
              ),
              onTap: () async {
                final KycControllerPan kycController = Get.put(KycControllerPan());

                // Fetch user profile
                Map<String, dynamic>? userProfile =
                    await ApiService.getUserProfile();

                if (userProfile == null) {
                  print("No user profile found.");
                  return;
                }

                // Extract and trim values safely
                String? email = userProfile['email']?.trim();
                String? name = userProfile['name']?.trim();

                if (email == null ||
                    email.isEmpty ||
                    name == null ||
                    name.isEmpty) {
                  print("Error: Email or Name is missing.");
                  return;
                }

                // Directly submit the KYC form
                kycController.submitKycForm(
                  customerIdentifier: email,
                  customerName: name,
                );

                print("✅ Name: $name");
                print("✅ E-Mail: $email");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKycOption({required String title, required String imagePath}) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(12),
      dashPattern: [6, 3],
      color: AppColors.kycBorderDot,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: AppColors.kycBorderDotShadow,
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.kycTextColor,
              ),
            ),
            Image.asset(
              imagePath,
              width: 60,
              height: 60,
              // fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
