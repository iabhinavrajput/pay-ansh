import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:payansh/components/custom_app_bar_kyc.dart';
import 'package:payansh/constants/app_colors.dart';

class KycThree extends StatelessWidget {
  const KycThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBarKYC(
        title: "Upload Documents",
        description: "Please note that your Aadhaar number\nto be verified during KYC verification",
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "KYC by Aadhaar",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(
                hintText: "Enter Your Aadhaar Card Number",
                 labelText: 'Aadhaar Card Number',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  
                ),
                
              ),
              
            ),
            const SizedBox(height: 20),
            const Center(child: Text("or" , style: TextStyle(color: Colors.grey))),
            const SizedBox(height: 20),
            const Text(
              "Upload Your Aadhaar Card*",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              // InputDecoration(border: OutlineInputBorder(), labelText: 'Password'),
            ),
            const SizedBox(height: 10),
            _buildUploadBox("Upload Aadhaar Card (Front)"),
            const SizedBox(height: 15),
            _buildUploadBox("Upload Aadhaar Card (Back)"),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadBox(String text) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(10),
      dashPattern: const [5, 5],
      color: Colors.grey,
      strokeWidth: 1.5,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
