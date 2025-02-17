import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/routes/routes.dart';
import 'package:payansh/widgets/app_bar.dart';
import '../utils/local_storage.dart';
import '../screens/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Future<void> logout() async {
  //   await LocalStorage.clearUserToken();
  //   Get.offAll(() => LoginScreen());
  // }
  Future<void> logout() async {
    await LocalStorage.clearUserToken();
    Get.offAll(() => AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(height: 50),
      // body: Center(
      //   child: ElevatedButton(
      //     // onPressed: logout,
      //     onPressed: () async {
      //       print('inside logout');
      //       await LocalStorage.clearUserToken();
      //       Get.offAll(() => LoginScreen());
      //     },
      //     child: const Text("Logout"),
      //   ),
      // ),

      
    );
  }
}
