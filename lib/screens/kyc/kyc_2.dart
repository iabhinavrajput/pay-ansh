import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:payansh/components/custom_app_bar_kyc.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/controllers/kyc_controller_aadhar.dart';
import 'package:payansh/controllers/kyc_controller_pan.dart';
import 'package:payansh/services/api_service.dart';

class KycTwo extends StatelessWidget {
  const KycTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarKYC(
        title: "Upload Documents",
        description:
            "Please note that you can proceed\nthrough Aadhar or PAN Number",
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            GestureDetector(
              child: _buildKycOption(
                title: "KYC By Aadhaar",
                imagePath: "assets/kyc/aadhar.png",
              ),
              onTap: () => _handleKycSubmission(KycControllerAadhar()),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              child: _buildKycOption(
                title: "KYC By PAN",
                imagePath: "assets/kyc/pan.png",
              ),
              onTap: () => _handleKycSubmission(KycControllerPan()),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleKycSubmission(dynamic kycController) async {
    final controller = Get.put(kycController);

    // Show loading dialog
    Get.dialog(
       const Center(child: SpinKitSquareCircle(
        color: AppColors.gradientStart,
        size: 40
       )),
      barrierDismissible: false,
    );

    try {
      // Fetch user profile
      Map<String, dynamic>? userProfile = await ApiService.getUserProfile();

      // Close the loader
      Get.back();

      if (userProfile == null) {
        print("No user profile found.");
        return;
      }

      // Extract and trim values safely
      String? email = userProfile['email']?.trim();
      String? name = userProfile['name']?.trim();

      if (email == null || email.isEmpty || name == null || name.isEmpty) {
        print("Error: Email or Name is missing.");
        return;
      }

      // Directly submit the KYC form
      controller.submitKycForm(
        customerIdentifier: email,
        customerName: name,
      );

      print("✅ Name: $name");
      print("✅ E-Mail: $email");
    } catch (e) {
      // Close the loader in case of an error
      Get.back();
      print("Error fetching user profile: $e");
    }
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
            ),
          ],
        ),
      ),
    );
  }
}
