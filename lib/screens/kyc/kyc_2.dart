import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payansh/components/custom_app_bar_kyc.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';

class KycTwo extends StatelessWidget {
  const KycTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarKYC(
        title: "Upload Documents",
        description: "Please note that you can proceed with KYC\nthrough Aadhar Number or PAN Number",
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            _buildKycOption(
              title: "KYC By Aadhar",
              imagePath: "assets/kyc/aadhar.png",
            ),
            const SizedBox(height: 20),
            _buildKycOption(
              title: "KYC By PAN",
              imagePath: "assets/kyc/pan.png",
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
