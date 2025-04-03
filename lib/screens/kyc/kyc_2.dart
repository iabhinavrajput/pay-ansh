import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/components/custom_app_bar_kyc.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:payansh/controllers/kyc_controller_aadhar.dart';
import 'package:payansh/controllers/kyc_controller_pan.dart';
import 'package:payansh/services/api_service.dart';
import 'package:payansh/utils/snackbar_util.dart';

class KycTwo extends StatefulWidget {
  const KycTwo({Key? key}) : super(key: key);

  @override
  _KycTwoState createState() => _KycTwoState();
}

class _KycTwoState extends State<KycTwo> {
  String? kycStatus;
  Map<String, dynamic>? userProfile;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    userProfile = await ApiService.getUserProfile();
    setState(() {
      kycStatus = userProfile?['kyc_status'];
    });
  }

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
        child: kycStatus == "approved"
            ? _buildStatusUI(
                text: "Verified",
                color: const Color(0xff47C546),
                icon: Icons.check_circle,
                message: "Your KYC was verified successfully.",
              )
            : Column(
                children: [
                  GestureDetector(
                    child: _buildKycOption(
                      title: "KYC By Aadhar",
                      imagePath: "assets/kyc/aadhar.png",
                    ),
                    onTap: () async {
                      if (userProfile == null) return;
                      String? email = userProfile!['email']?.trim();
                      String? name = userProfile!['name']?.trim();
                      if (email == null || name == null) return;
                      Get.put(KycControllerAadhar()).submitKycForm(
                        customerIdentifier: email,
                        customerName: name,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    child: _buildKycOption(
                      title: "KYC By PAN",
                      imagePath: "assets/kyc/pan.png",
                    ),
                    onTap: () async {
                      if (userProfile == null) return;
                      String? email = userProfile!['email']?.trim();
                      String? name = userProfile!['name']?.trim();
                      if (email == null || name == null) return;
                      Get.put(KycControllerPan()).submitKycForm(
                        customerIdentifier: email,
                        customerName: name,
                      );
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusUI({
    required String text,
    required Color color,
    required IconData icon,
    required String message,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Row(
        children: [
          Icon(icon, color: color, size: 40),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  message,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
