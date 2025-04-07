import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/api_endpoints.dart';
import 'package:payansh/constants/app_constants.dart';
import '../models/kyc_status_model.dart';
// assuming token is stored here

class KycService {
  static Future<KycStatusModel?> fetchKycStatus() async {
    try {
      final response = await Dio().get(
        "${ApiEndpoints.baseUrl2}/verification/process",
        options: Options(
          headers: {
            'Authorization': 'Bearer ${AppConstants.authToken}',
          },
        ),
      );
      if (response.statusCode == 200) {
        return KycStatusModel.fromJson(response.data['data']);
      }
    } catch (e) {
      print("KYC status fetch error: $e");
    }
    return null;
  }
}
