import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:payansh/components/custom_app_bar_kyc.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/controllers/%20kyc_controller.dart';
import 'package:payansh/controllers/kyc_controller_aadhar.dart';
import 'package:payansh/screens/kyc/kyc_3.dart';
import 'package:payansh/screens/kyc/kyc_4.dart';
import 'package:payansh/controllers/kyc_controller_pan.dart';
import 'package:payansh/services/api_service.dart';
import 'package:payansh/utils/snackbar_util.dart';

class KycTwo extends StatelessWidget {
  KycTwo({Key? key}) : super(key: key);
  final KycController kycController = Get.put(KycController());

  void _handleKycSubmission(Widget controllerWidget) {
    Get.to(() => controllerWidget);
  }

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
        child: Obx(() {
          final kyc = kycController.kycStatus.value;
          if (kycController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              kyc?.aadhaar == true
                  ? _buildStatusUI(
                      text: "Verified",
                      color: const Color(0xff47C546),
                      icon: Icons.check_circle,
                      message: "Your Aadhaar was verified successfully.",
                      documentType: "Aadhaar", context: context,
                    )
                  : GestureDetector(
                      child: _buildKycOption(
                        title: "KYC By Aadhar",
                        imagePath: "assets/kyc/aadhar.png",
                      ),
                      onTap: () async {
                        final KycControllerAadhar kycController =
                            Get.put(KycControllerAadhar());

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
              kyc?.pan == true
                  ? _buildStatusUI(
                      text: "Verified",
                      color: const Color(0xff47C546),
                      icon: Icons.check_circle,
                      message: "Your PAN was verified successfully.",
                      documentType: "PAN", context: context,
                    )
                  : GestureDetector(
                      child: _buildKycOption(
                        title: "KYC By PAN",
                        imagePath: "assets/kyc/pan.png",
                      ),
                      onTap: () async {
                        final KycControllerPan kycController =
                            Get.put(KycControllerPan());

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
          );
        }),
      ),
    );
  }

  Widget _buildStatusUI({
    required context,
    required String text,
    required Color color,
    required IconData icon,
    required String message,
    required String documentType,
  }) {
    return Column(
      children: [
      
        Container(
          width: Dimensions.dynamicWidth(context, 1),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 40),
              SizedBox(height: 10),
              Text(message, style: TextStyle(color: Color(0xff5A5A5B))),
            ],
          ),
        ),
      ],
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
