import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/local_storage.dart';
import '../screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  Future<void> logout() async {
    await LocalStorage.removeUserToken();
    Get.offAll(() => LoginScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Center(
        child: ElevatedButton(
          onPressed: logout,
          child: Text("Logout"),
        ),
      ),
    );
  }
}
