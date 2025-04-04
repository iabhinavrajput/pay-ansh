import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:payansh/constants/api_endpoints.dart';
import 'package:payansh/utils/snackbar_util.dart';

class ComplaintController extends GetxController {
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  var complaintTypes = <Map<String, dynamic>>[].obs; // Stores both id and type
  var complaintReasons =
      <Map<String, dynamic>>[].obs; // Stores both id and reason
  var isLoading = false.obs;
  var isLoaded = false.obs; // New variable to check if data is fully loaded

  // Declare reactive variables for selected types and reasons
  var selectedComplaintType = ''.obs;
  var selectedComplaintReason = ''.obs;
  var isComplaintTypeSelected = false.obs;
  var isComplaintReasonSelected = false.obs;

  var complaintStatuses = <Map<String, dynamic>>[].obs;

  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchComplaintData();
    super.onInit();
  }

  void onSelectComplaintType(String value) {
    selectedComplaintType.value = value; // Update the reactive variable
    isComplaintTypeSelected.value = true;
    validateForm();
  }

  void onSelectComplaintReason(String value) {
    selectedComplaintReason.value = value; // Update the reactive variable
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

      print('response: ${response.data}');

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

  Future<void> fetchComplaintDetails(String typeId, String complaintId) async {
    isLoading.value = true;
    try {
      String? token = await _storage.read(key: "accessToken");
      final response = await _dio.get(
        ApiEndpoints.complaints,
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        }),
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data["success"] == true) {
          List<dynamic> complaints = data["data"]["complaints"];
          var complaint = complaints.firstWhereOrNull(
            (c) =>
                c["type_id"].toString() == typeId &&
                c["complaint_code"].toString() == complaintId,
          );

          if (complaint != null) {
            complaintStatuses.value = [
              {
                "status": "Complaint Registered Successfully",
                "dateTime": complaint["created_at"]
              },
              {
                "status": "Status: ${complaint["status"]}",
                "dateTime": complaint["created_at"]
              },
            ];
          } else {
            errorMessage.value = "No complaint found for the given details.";
          }
        } else {
          errorMessage.value = "Failed to fetch complaints.";
        }
      } else {
        errorMessage.value = "Server error. Please try again later.";
      }
    } catch (e) {
      errorMessage.value =
          "Something went wrong. Please check your connection.";
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> submitComplaint({
    required String typeId,
    required String reasonId,
    required String subject,
    required String description,
  }) async {
    try {
      String? token = await _storage.read(key: "accessToken");

      final response = await _dio.post(
        ApiEndpoints.complaints,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
          validateStatus: (status) => status != null && status < 500,
        ),
        data: {
          "typeId": typeId,
          "reasonId": reasonId,
          "subject": subject,
          "description": description,
        },
      );

      final data = response.data;
      print("Response Data: $data");

      if (response.statusCode == 201) {
        String message = data["message"]?.toString() ?? "Complaint registered";
        String complaintCode =
            data["data"]["complaintCode"]?.toString() ?? "N/A";

        print("Complaint Message: $message");
        print("Complaint Code: $complaintCode");

        showSnackbar(
          title: data["status"]?.toString() ?? "Success",
          message: "$message\nComplaint Code: $complaintCode",
          isSuccess: data["success"] ?? false,
        );
        return true;
      } else {
        String message =
            data["message"]?.toString() ?? "Complaint not registered";
        showSnackbar(
          title: "Error",
          message: message,
          isSuccess: false,
        );
        return false; 
      }
    } catch (e) {
      print("Exception: $e");

      showSnackbar(
        title: "Error",
        message: "An unexpected error occurred.",
        isSuccess: false,
      );
      return false; 
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







// import 'package:get/get.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:payansh/constants/api_endpoints.dart';
// import 'package:payansh/utils/snackbar_util.dart';
// import 'dart:convert';

// class ComplaintController extends GetxController {
//   final Dio _dio = Dio();
//   final FlutterSecureStorage _storage = const FlutterSecureStorage();

//   var complaintTypes = <Map<String, dynamic>>[].obs;
//   var complaintReasons = <Map<String, dynamic>>[].obs;
//   var complaintStatuses = <Map<String, dynamic>>[].obs;
//   var isLoading = false.obs;
//   var isLoaded = false.obs;

//   var selectedComplaintType = ''.obs;
//   var selectedComplaintReason = ''.obs;
//   var isComplaintTypeSelected = false.obs;
//   var isComplaintReasonSelected = false.obs;
//   var errorMessage = ''.obs;

//   @override
//   void onInit() {
//     fetchComplaintData();
//     super.onInit();
//   }

//   void onSelectComplaintType(String value) {
//     selectedComplaintType.value = value;
//     isComplaintTypeSelected.value = true;
//     validateForm();
//   }

//   void onSelectComplaintReason(String value) {
//     selectedComplaintReason.value = value;
//     isComplaintReasonSelected.value = true;
//     validateForm();
//   }

//   Future<void> fetchComplaintData() async {
//     isLoading.value = true;
//     try {
//       String? token = await _storage.read(key: "accessToken");
//       final response = await _dio.get(
//         ApiEndpoints.complaintTypesReason,
//         options: Options(headers: {"Authorization": "Bearer $token"}),
//       );

//       if (response.statusCode == 200 && response.data["success"] == true) {
//         var types = response.data["data"]["type"] as List;
//         complaintTypes.value =
//             types.map((e) => {"id": e["id"], "type": e["type"]}).toList();

//         var reasons = response.data["data"]["reason"] as List;
//         complaintReasons.value =
//             reasons.map((e) => {"id": e["id"], "reason": e["reason"]}).toList();

//         isLoaded.value = true;
//       }
//     } catch (e) {
//       print("Error fetching complaint data: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }

  

//   void validateForm() {
//     if (isComplaintTypeSelected.value && isComplaintReasonSelected.value) {
//       // Enable submit button logic here
//     }
//   }
// }

