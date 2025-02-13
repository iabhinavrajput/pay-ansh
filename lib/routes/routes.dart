import 'package:get/get.dart';
import 'package:payansh/screens/home_screen.dart';
import 'package:payansh/screens/login_screen.dart';
import 'package:payansh/screens/otp_verification.dart';

class AppRoutes {
  static const String login = '/';
  static const String otp = '/otp';
  static const String home = '/home';

  static List<GetPage> routes = [
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(
        name: otp,
        page: () => OtpVerification(userId: 123)), // Pass userId dynamically
    GetPage(name: home, page: () => const HomeScreen()),
  ];
}
