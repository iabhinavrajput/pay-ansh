import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/controllers/auth_controller.dart';
import 'package:payansh/screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthController authController = Get.put(AuthController());
  authController.checkLoginStatus();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payansh',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

