import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:payansh/constants/api_endpoints.dart';
import 'package:payansh/screens/otp_verification.dart';
import 'package:payansh/utils/snackbar_util.dart';

class SignupController extends GetxController {
  final Dio _dio = Dio();
  final isLoading = false.obs;
  var userId = 0.obs; // Store user ID

  Future<void> signup(
      String name, String email, String password, String phone) async {
    isLoading.value = true;
    try {
      final response = await _dio.post(
        "${ApiEndpoints.baseUrl}/signup",
        data: {
          "name": name,
          "email": email,
          "password": password,
          "phoneNumber": phone,
        },
      );

      if (response.statusCode == 201) {
        print("Signup Response: ${response.data}");
        final responseData = response.data;
        userId.value = responseData["data"]["userId"]; // Store userId

        showSnackbar(
          title: "Success",
          message: responseData['message'] ?? "Signup successful!",
          isSuccess: true,
        );
        // Navigate to OTP Screen and pass userId
        Get.to(() => OtpVerification(userId: userId.value));
      } else {
        _handleErrorResponse(response);
      }
    } on DioException catch (e) {
      _handleDioException(e);
    } catch (e) {
      print("Unexpected Error: $e");
      showSnackbar(title: "Error", message: "Something went wrong!", isSuccess: false);
    } finally {
      isLoading.value = false;
    }
  }

  /// Handles API response errors dynamically
  void _handleErrorResponse(response) {
    final responseData = response.data;
    if (responseData is Map && responseData.containsKey('message')) {
      showSnackbar(title: "Error", message: responseData['message'], isSuccess: false);
    } else {
      showSnackbar(title: "Error", message: "Unexpected error occurred!", isSuccess: false);
    }
  }

  /// Handles network and request errors
  void _handleDioException(DioException e) {
    if (e.response != null) {
      // Server responded with an error
      _handleErrorResponse(e.response!);
    } else if (e.type == DioExceptionType.connectionTimeout || 
               e.type == DioExceptionType.receiveTimeout || 
               e.type == DioExceptionType.sendTimeout) {
      showSnackbar(title: "Network Error", message: "Connection timed out!", isSuccess: false);
    } else if (e.type == DioExceptionType.connectionError) {
      showSnackbar(title: "Network Error", message: "No internet connection!", isSuccess: false);
    } else {
      showSnackbar(title: "Error", message: "Something went wrong!", isSuccess: false);
    }
  }

  /// Handles network and request errors
  // void _handleDioException(DioException e) {
  //   if (e.response != null) {
  //     // Server responded with an error
  //     _handleErrorResponse(e.response!);
  //   } else if (e.type == DioExceptionType.connectionTimeout || 
  //              e.type == DioExceptionType.receiveTimeout || 
  //              e.type == DioExceptionType.sendTimeout) {
  //     showSnackbar(title: "Network Error", message: "Connection timed out!", isSuccess: false);
  //   } else if (e.type == DioExceptionType.connectionError) {
  //     showSnackbar(title: "Network Error", message: "No internet connection!", isSuccess: false);
  //   } else {
  //     showSnackbar(title: "Error", message: "Something went wrong!", isSuccess: false);
  //   }
  // }
}