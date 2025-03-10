import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:payansh/controllers/auth_controller.dart';
import 'package:payansh/routes/routes.dart';
import 'package:payansh/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // final AuthController authController = Get.put(AuthController());
  // authController.checkLoginStatus();
  await Firebase.initializeApp();
  Get.put(AuthController()); // Initialize controller
  await GetStorage.init(); // Initialize GetStorage
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
        textTheme: GoogleFonts.poppinsTextTheme(),
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
