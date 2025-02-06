import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<void> saveUserToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
  }

  static Future<String?> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  static Future<void> removeUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
  }
}
