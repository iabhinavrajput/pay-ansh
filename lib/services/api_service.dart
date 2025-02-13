import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';

class ApiService {
  /// **User Login API**
  static Future<Map<String, dynamic>> loginUser(
      String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.login),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["status"] == "success") {
          return {
            "success": true,
            "message": "Login successful",
            "accessToken": data["data"]["tokens"]["accessToken"]
          };
        } else {
          final data = jsonDecode(response.body);
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
}
