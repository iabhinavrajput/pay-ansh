import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:payansh/constants/api_endpoints.dart';

class ComplaintController extends GetxController {
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  var complaintTypes = <Map<String, dynamic>>[].obs; // Stores both id and type
  var complaintReasons = <Map<String, dynamic>>[].obs; // Stores both id and reason
  var isLoading = false.obs;
  var isLoaded = false.obs; // New variable to check if data is fully loaded

  // Declare reactive variables for selected types and reasons
  var selectedComplaintType = ''.obs;
  var selectedComplaintReason = ''.obs;
  var isComplaintTypeSelected = false.obs;
  var isComplaintReasonSelected = false.obs;

  @override
  void onInit() {
    fetchComplaintData();
    super.onInit();
  }

  void onSelectComplaintType(String value) {
    selectedComplaintType.value = value;  // Update the reactive variable
    isComplaintTypeSelected.value = true;
    validateForm();
  }

  void onSelectComplaintReason(String value) {
    selectedComplaintReason.value = value;  // Update the reactive variable
    isComplaintReasonSelected.value = true;
    validateForm();
  }

  Future<void> fetchComplaintData() async {
    isLoading.value = true;
    try {
      String? token = await _storage.read(key: "accessToken");
      final response = await _dio.get(
        ApiEndpoints.complaintTypesReason,
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      if (response.statusCode == 200 && response.data["success"] == true) {
        var types = response.data["data"]["type"] as List;
        complaintTypes.value =
            types.map((e) => {"id": e["id"], "type": e["type"]}).toList();

        var reasons = response.data["data"]["reason"] as List;
        complaintReasons.value =
            reasons.map((e) => {"id": e["id"], "reason": e["reason"]}).toList();
        
        isLoaded.value = true; // Mark data as loaded
      }
    } catch (e) {
      print("Error fetching complaint data: $e");
    } finally {
      isLoading.value = false;
    }
  }

Future<void> submitComplaint({
  required String typeId,
  required String reasonId,
  required String subject,
  required String description,
}) async {
  try {
    String? token = await _storage.read(key: "accessToken");

    // Now you can directly use typeId and reasonId since they are string ids
    final response = await _dio.post(
      "https://api.payansh.com/api/complaints",
      options: Options(
        headers: {"Authorization": "Bearer $token"},
      ),
      data: {
        "typeId": typeId,  // Use the string ids here
        "reasonId": reasonId,
        "subject": subject,
        "description": description,
      },
    );

  print("responseofthecomplain: ${response.data}");
  print("status code: ${response.statusCode}");
    if (response.statusCode == 201) {
      
      Get.snackbar("Success", "Complaint registered successfully!");
    } else {
      Get.snackbar("Error", "Failed to register complaint");
    }
  } catch (e) {
    Get.snackbar("Error", "Something went wrong: $e");
  }
}


  // Add validation for form here (if needed)
  void validateForm() {
    // Implement validation logic, for example:
    if (isComplaintTypeSelected.value && isComplaintReasonSelected.value) {
      // Enable submit button or something else
    }
  }
}
