// import 'package:flutter/material.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:payansh/components/custom_app_bar_kyc.dart';
// import 'package:payansh/constants/app_colors.dart';
// import 'package:payansh/screens/trial/kyc_controller.dart';
// import 'package:payansh/services/api_service.dart';

// class KycFour extends StatelessWidget {
//   const KycFour({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const CustomAppBarKYC(
//         title: "Upload Documents",
//         description:
//             "Please note that your PAN number\nneeds to be verified during KYC verification",
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(25.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // const Text(
//             //   "KYC by PAN",
//             //   style: TextStyle(
//             //     fontSize: 16,
//             //     fontWeight: FontWeight.w400,
//             //   ),
//             // ),
//             // const SizedBox(height: 8),
//             // TextField(
//             //   decoration: InputDecoration(
//             //     hintText: "Enter Your Pan Card Number",
//             //      labelText: 'Pan Card Number',
//             //     border: OutlineInputBorder(
//             //       borderRadius: BorderRadius.circular(10),

//             //     ),

//             //   ),

//             // ),
//             // const SizedBox(height: 20),
//             // const Center(child: Text("or" , style: TextStyle(color: Colors.grey))),
//             // const SizedBox(height: 20),

//             const Text(
//               "Upload Your PAN Card*",
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//               ),
//               // InputDecoration(border: OutlineInputBorder(), labelText: 'Password'),
//             ),
//             const SizedBox(height: 10),

//             GestureDetector(
//   child: _buildUploadBox("Upload PAN Card (Front)"),
//   onTap: () async {
//     final KycController kycController = Get.put(KycController());

//     // Fetch user profile
//     Map<String, dynamic>? userProfile = await ApiService.getUserProfile();

//     if (userProfile == null) {
//       print("No user profile found.");
//       return;
//     }

//     // Extract and trim values safely
//     String? email = userProfile['email']?.trim();
//     String? name = userProfile['name']?.trim();

//     if (email == null || email.isEmpty || name == null || name.isEmpty) {
//       print("Error: Email or Name is missing.");
//       return;
//     }

//     // Directly submit the KYC form
//     kycController.submitKycForm(
//       customerIdentifier: email,
//       customerName: name,
//     );

//     print("✅ Name: $name");
//     print("✅ E-Mail: $email");
//   },
// ),


//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildUploadBox(String text) {
//     return DottedBorder(
//       borderType: BorderType.RRect,
//       radius: const Radius.circular(10),
//       dashPattern: const [5, 5],
//       color: Colors.grey,
//       strokeWidth: 1.5,
//       child: Container(
//         width: double.infinity,
//         padding: const EdgeInsets.symmetric(vertical: 20),
//         child: Center(
//           child: Text(
//             text,
//             style: const TextStyle(
//               fontSize: 16,
//               color: Colors.black,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
