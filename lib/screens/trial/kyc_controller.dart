import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:payansh/screens/trial/kyc2.dart';

class KycController extends GetxController {
  final Dio _dio = Dio();
  var isLoading = false.obs;

  Future<void> submitKycForm({
    required String customerIdentifier,
    required String customerName,
  }) async {
    isLoading.value = true;

    const String url =
        "https://api.digio.in/client/kyc/v2/request/with_template";
    const String clientId = "AIVXMGKKJ2O1R668PJOYPV66RGDBBEVZ";
    const String clientSecret = "AJIBVQ7MT4FBZ318UG9S5SNG9P56CZLV";

    final String authHeader =
        "Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}";

    try {
      final response = await _dio.post(
        url,
        data: {
          "customer_identifier": customerIdentifier,
          "customer_name": customerName,
          "reference_id": "",
          "template_name": "PAN_VERIFICATION",
          "notify_customer": true,
          "request_details": {},
          "transaction_id": "",
          "generate_access_token": true,
        },
        options: Options(
          headers: {
            "authorization": authHeader,
            "content-type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        String kid = data["id"];
        String accessToken = data["access_token"]["id"];

        Get.snackbar("Success", "KYC Request submitted successfully");

        // Navigate to Workflow Screen with data
        Get.to(() => WorkflowScreen(), arguments: {
          "kid": kid,
          "accessToken": accessToken,
          "email": customerIdentifier
        });
      } else {
        Get.snackbar("Error", "Failed to submit KYC");
      }
    } catch (e) {
      isLoading.value = false;

      Get.snackbar("Error", e.toString());
    }
  }
}
