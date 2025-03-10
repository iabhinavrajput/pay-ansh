import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:payansh/constants/api_endpoints.dart';
import 'package:payansh/constants/app_constants.dart';
import 'package:payansh/screens/device_info.dart';
import 'package:payansh/screens/login_screen.dart';
import 'package:payansh/utils/local_storage.dart';

class ApiService {
  /// **User Login API**
  ///
  ///
  static Future<Map<String, dynamic>> loginUser(
      String email, String password) async {
    try {
      final deviceInfo = await DeviceInfoHelper.getDeviceInfo();

      final response = await http.post(
        Uri.parse(ApiEndpoints.login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
          "deviceInfo": deviceInfo,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["status"] == "success") {
          String accessToken = data["data"]["tokens"]["accessToken"];
          String refreshToken = data["data"]["tokens"]["refreshToken"];

          // Store tokens
          await LocalStorage.saveUserToken(accessToken);
          await LocalStorage.saveRefreshToken(refreshToken);

          // Assign global auth token
          AppConstants.authToken = accessToken;

          return {
            "success": true,
            "message": "Login successful",
            "accessToken": accessToken
          };
        } else {
          return {"success": false, "message": data["message"]};
        }
      } else {
        final data = jsonDecode(response.body);
        return {"success": false, "message": data["message"]};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  /// 🛠 Function to handle API requests with token refresh logic
  static Future<http.Response> makeAuthenticatedRequest(
      String url, String method,
      {Map<String, dynamic>? body}) async {
    String? accessToken = await LocalStorage.getUserToken();
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken",
    };

    http.Response response;

    try {
      if (method == "POST") {
        response = await http.post(Uri.parse(url),
            headers: headers, body: jsonEncode(body));
      } else if (method == "GET") {
        response = await http.get(Uri.parse(url), headers: headers);
      } else {
        throw Exception("Unsupported HTTP method");
      }

      if (response.statusCode == 401) {
        // Access token expired, attempt to refresh
        bool refreshed = await _refreshToken();
        if (refreshed) {
          // Retry the original request with new token
          String? newAccessToken = await LocalStorage.getUserToken();
          final newHeaders = {
            "Content-Type": "application/json",
            "Authorization": "Bearer $newAccessToken",
          };

          if (method == "POST") {
            response = await http.post(Uri.parse(url),
                headers: newHeaders, body: jsonEncode(body));
          } else {
            response = await http.get(Uri.parse(url), headers: newHeaders);
          }
        }
      }
      return response;
    } catch (e) {
      throw Exception("API Request failed: $e");
    }
  }

  /// 🛠 Function to refresh the access token
  static Future<bool> _refreshToken() async {
    String? refreshToken = await LocalStorage.getRefreshToken();
    if (refreshToken == null) {
      print("No refresh token found, user must log in again.");
      _handleInvalidSession();
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.refreshtoken),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"refreshToken": refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["status"] == "success") {
          String newAccessToken = data["data"]["accessToken"];
          String newRefreshToken = data["data"]["refreshToken"];

          // Save new tokens
          await LocalStorage.saveUserToken(newAccessToken);
          await LocalStorage.saveRefreshToken(newRefreshToken);

          // Update global token
          AppConstants.authToken = newAccessToken;
          print("🔄 Token refreshed successfully!");
          return true;
        }
      } else if (response.statusCode == 401) {
        final data = jsonDecode(response.body);
        if (data["message"] == "Invalid refresh token") {
          print("❌ Invalid refresh token, multiple device login detected.");
          _handleInvalidSession();
        }
      }

      return false;
    } catch (e) {
      print("❌ Refresh token request failed: $e");
      return false;
    }
  }

  static void _handleInvalidSession() {
    Get.snackbar(
      "Session Expired",
      "Same credentials have been used to log in on another device. To continue using this device, log out from the other device.",
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 5),
    );

    // Clear user tokens
    LocalStorage.clearUserToken();
    AppConstants.authToken = null;

    // Redirect to login screen
    Get.offAll(() => LoginScreen());
  }

  /// **Forgot Password API**
  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.forgotPassword),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          "success": data["status"] == "success",
          "message": data["message"]
        };
      } else {
        final data = jsonDecode(response.body);
        return {"success": false, "message": data["message"]};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  /// **Step 2: Verify OTP API**
  static Future<Map<String, dynamic>> verifyResetOTP(
      String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.verifyOTP),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "otp": otp}),
      );

      final data = jsonDecode(response.body);
      if (response.statusCode == 200 && data["status"] == "success") {
        return {"success": true, "resetToken": data["data"]["resetToken"]};
      } else {
        return {"success": false, "message": data["message"]};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  /// **Step 3: Reset Password API**
  static Future<Map<String, dynamic>> resetPassword(
      String resetToken, String newPassword, String confirmPassword) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.resetPassword),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "resetToken": resetToken,
          "newPassword": newPassword,
          "confirmPassword": confirmPassword,
        }),
      );

      final data = jsonDecode(response.body);
      return {
        "success": data["status"] == "success",
        "message": data["message"]
      };
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  /// **Sign-Up OTP Verification API**
  static Future<Map<String, dynamic>> verifySignupOTP(
      int userId, String otp) async {
    try {
      final response = await http.post(
        Uri.parse("${ApiEndpoints.baseUrl}/verify-email/$userId"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"otp": otp}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["status"] == "success") {
          return {"success": true, "message": data["message"]};
        } else {
          return {"success": false, "message": data["message"]};
        }
      } else {
        final data = jsonDecode(response.body);
        return {"success": false, "message": data["message"]};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  /// **User Profile API**
  static Future<Map<String, dynamic>?> getUserProfile() async {
    try {
      // Retrieve token from AppConstants
      String? token = AppConstants.authToken;
      if (token == null) return null;

      final response = await http.get(
        Uri.parse(ApiEndpoints.profileEndpoint),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      bool refreshed = await _refreshToken();
      if (refreshed) {
        // Retry the request with new token
        String? newToken = AppConstants.authToken;
        if (newToken == null) return null;

        final retryResponse = await http.get(
          Uri.parse(ApiEndpoints.profileEndpoint),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $newToken",
          },
        );

        if (retryResponse.statusCode == 200) {
          return jsonDecode(retryResponse.body);
        }
      }
    } catch (e) {
      print("Error fetching profile: ${e.toString()}");
      return null;
    }
  }

  // **Update Profile API**
  /// Pass new name and/or phone number. Only fields provided will be updated.
  static Future<Map<String, dynamic>> updateProfile(
      {String? name, String? phoneNumber}) async {
    try {
      Map<String, dynamic> body = {};
      if (name != null) body["name"] = name;
      if (phoneNumber != null) body["phone_number"] = phoneNumber;

      final token = AppConstants.authToken;
      final response = await http.put(
        Uri.parse(ApiEndpoints.profileUpdate),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode(body),
      );

      // Debug logs: print status code and raw response body.
      print("Update API status code: ${response.statusCode}");
      print("Update API response body: ${response.body}");

      // Check if the response is in JSON format.
      if (response.body.trim().startsWith("{") ||
          response.body.trim().startsWith("[")) {
        final decoded = jsonDecode(response.body);
        return decoded;
      } else {
        return {"success": false, "message": "Unexpected response format"};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  /// Update Profile Picture API using multipart/form-data with POST.
  static Future<Map<String, dynamic>> updateProfilePicture(
      File imageFile) async {
    try {
      final token = AppConstants.authToken;
      if (token == null) {
        return {"success": false, "message": "No auth token found"};
      }

      final uri = Uri.parse(ApiEndpoints.uploadProfilePicture);
      final request = http.MultipartRequest('POST', uri);

      // Set the Authorization header.
      request.headers["Authorization"] = "Bearer $token";
      // Note: Don't manually set the Content-Type header here.

      // Attach the image file with the expected field name.
      request.files.add(
          await http.MultipartFile.fromPath('profile_picture', imageFile.path));

      final streamedResponse = await request.send();
      final responseString = await streamedResponse.stream.bytesToString();

      print("Upload profile picture status: ${streamedResponse.statusCode}");
      print("Response: $responseString");

      if (streamedResponse.statusCode == 200) {
        final decoded = jsonDecode(responseString);
        return decoded;
      } else {
        return {"success": false, "message": "Upload failed"};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}
