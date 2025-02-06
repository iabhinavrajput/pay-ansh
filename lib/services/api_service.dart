import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_endpoints.dart';
import '../utils/local_storage.dart';

class ApiService {
  static Future<Map<String, dynamic>> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiEndpoints.login),
        body: ({"email": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["status"] == "success") {
          String accessToken = data["data"]["tokens"]["accessToken"];
          await LocalStorage.saveUserToken(accessToken);
          return {"success": true, "message": "Login successful", "data": data["data"]["user"]};
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
}
