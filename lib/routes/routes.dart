import 'package:get/get.dart';
import 'package:payansh/screens/drawer_navigation.dart';
import 'package:payansh/screens/home_screen.dart';
import 'package:payansh/screens/login_screen.dart';
import 'package:payansh/screens/otp_verification.dart';
import 'package:payansh/screens/profile_screen.dart';
import 'package:payansh/screens/recharge_bills.dart';

class AppRoutes {
  static const String login = '/';
  static const String otp = '/otp';
  static const String home = '/home';
  static const String drawerNavigation = '/drawer_navigation';
  static const String profileScreen = '/profile_screen';

  static List<GetPage> routes = [
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(
        name: otp,
        page: () => OtpVerification(userId: 123)), // Pass userId dynamically
    GetPage(name: home, page: () =>  RechargeBillPage()),
    GetPage(name: home, page: () =>  const HomeScreen()),
    GetPage(name: drawerNavigation, page :() =>   DrawerNavigation()),
    GetPage(name: profileScreen, page: () => const ProfileScreen()),
  ];
}
