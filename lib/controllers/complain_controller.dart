import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:payansh/constants/api_endpoints.dart';
import 'package:payansh/services/dio_client.dart';

class ComplaintController extends GetxController {
  final dio = DioClient().dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  var complaintTypes = <String>[].obs;
  var complaintReasons = <String>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchComplaintData();
    super.onInit();
  }

  Future<void> fetchComplaintData() async {
    isLoading.value = true;
    try {
      String? token = await _storage.read(key: "accessToken");
      final response = await dio.get(
        ApiEndpoints.complaintTypesReason,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      if (response.statusCode == 200 && response.data["success"] == true) {
        var types = response.data["data"]["type"] as List;
        complaintTypes.value = types.map((e) => e["type"].toString()).toList();

        var reasons = response.data["data"]["reason"] as List;
        complaintReasons.value =
            reasons.map((e) => e["reason"].toString()).toList();
      }
    } catch (e) {
      print("Error fetching complaint data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
