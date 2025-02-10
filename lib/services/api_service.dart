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
          return {"success": false, "message": "Login failed"};
        }
      } else {
        return {"success": false, "message": "Server error"};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
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
        if (data["status"] == "success") {
          return {"success": true, "message": data["message"]};
        } else {
          return {"success": false, "message": "Failed to send OTP"};
        }
      } else {
        return {"success": false, "message": "Server error"};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  /// **Reset Password API**
 static Future<Map<String, dynamic>> resetPassword(String email, String otp,
      String newPassword, String confirmPassword) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.resetPassword),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "otp": otp,
          "newPassword": newPassword,
          "confirmPassword": confirmPassword,
        }),
      );

      print("🔹 Reset Password API Response: ${response.statusCode}");
      print("📜 Response Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["status"] == "success") {
          return {"success": true, "message": data["message"]};
        } else {
          print("❌ Reset Password Failed: ${data["message"]}");
          return {
            "success": false,
            "message": data["message"] ?? "Failed to reset password"
          };
        }
      } else {
        print("❌ Server Error: ${response.body}");
        return {"success": false, "message": "Server error: ${response.body}"};
      }
    } catch (e) {
      print("❌ Network Error: $e");
      return {"success": false, "message": "Network error: $e"};
    }
  }

  /// **Sign-Up OTP Verification API**
  static Future<Map<String, dynamic>> verifySignupOTP(int userId, String otp) async {
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
          return {"success": false, "message": "Invalid OTP"};
        }
      } else {
        return {"success": false, "message": "Server error"};
      }
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}
