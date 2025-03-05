import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/controllers/auth_controller.dart';
import 'package:payansh/routes/routes.dart';
import 'package:payansh/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    // Get.put(AuthController());
  await Firebase.initializeApp();
  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Payansh',
      getPages: AppRoutes.routes, 

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
