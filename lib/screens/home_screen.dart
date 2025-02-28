import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/routes/routes.dart';
import 'package:payansh/screens/device_info.dart';
import 'package:payansh/widgets/gradient_text.dart';
import 'package:payansh/widgets/recharge_grid.dart';
import 'package:payansh/screens/drawer_navigation.dart';
import '../utils/local_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<SliderDrawerState> _drawerKey = GlobalKey<SliderDrawerState>();

  Future<void> logout() async {
    await LocalStorage.clearUserToken();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderDrawer(
        key: _drawerKey,
        slider: DrawerNavigation(), // Sidebar Navigation
        child: SafeArea(
          child: Column(
            children: [
              // ✅ Restored Previous AppBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _drawerKey.currentState?.toggle(); // Open Sidebar
                      },
                      child: const CircleAvatar(
                        radius: 24,
                        backgroundColor: Colors.white,
                        child: Text("TU", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Test User",
                          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Welcome to Payance!",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.notifications, color: Colors.black),
                      onPressed: () {
                        // Notification Logic
                      },
                    ),
                  ],
                ),
              ),

              // ✅ Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const NoticeWidget(),
                        const SizedBox(height: 20),

                        // ✅ Banner Section
                        SizedBox(
                          height: 180,
                          child: PageView(
                            children: [
                              SvgPicture.asset("assets/banner/banner-1.svg", fit: BoxFit.fill),
                              SvgPicture.asset("assets/banner/sBanner-2.svg", fit: BoxFit.fill),
                              Image.asset("assets/banner/Banner-3.png", fit: BoxFit.fill),
                              SvgPicture.asset("assets/banner/sBanner-4.svg", fit: BoxFit.fill),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),

                        // ✅ Bank Banner
                        SvgPicture.asset(
                          "assets/banner/Link-Bank-Banner.svg",
                          width: MediaQuery.of(context).size.width,
                          height: 170,
                          fit: BoxFit.fill,
                        ),
                        const SizedBox(height: 10),

                        // ✅ Recharge & Bill Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/icon/Vector.svg"),
                                const SizedBox(width: 10),
                                const GradientText('Recharge & Bill Pays', style: TextStyle(fontSize: 19)),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.toNamed(AppRoutes.home);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                backgroundColor: AppColors.gradientStart,
                              ),
                              child: const Row(
                                children: [
                                  Text("View All", style: TextStyle(color: Colors.white, fontSize: 12)),
                                  Icon(Icons.arrow_forward),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // ✅ Recharge Grid (Scrollable)
                        const RechargeGrid(
                          iconData: [
                            {'image': 'assets/dashboard/bill.png', 'label': 'Bill\nPayment', 'screen': DeviceInfoScreen()},
                            {'image': 'assets/dashboard/mobile-recharge.png', 'label': 'Mobile\nRecharge', 'screen': DeviceInfoScreen()},
                            {'image': 'assets/dashboard/electricity-bill.png', 'label': 'Electricity', 'screen': DeviceInfoScreen()},
                            {'image': 'assets/dashboard/water-bill.png', 'label': 'Water\nBill', 'screen': DeviceInfoScreen()},
                            {'image': 'assets/dashboard/gas-cylinder.png', 'label': 'Gas\nPayment', 'screen': DeviceInfoScreen()},
                            {'image': 'assets/dashboard/bill.png', 'label': 'Bill\nPayment', 'screen': DeviceInfoScreen()},
                            {'image': 'assets/dashboard/mobile-recharge.png', 'label': 'Mobile\nRecharge', 'screen': DeviceInfoScreen()},
                            {'image': 'assets/dashboard/electricity-bill.png', 'label': 'Electricity', 'screen': DeviceInfoScreen()},
                            {'image': 'assets/dashboard/water-bill.png', 'label': 'Water\nBill', 'screen': DeviceInfoScreen()},
                            {'image': 'assets/dashboard/gas-cylinder.png', 'label': 'Gas\nPayment', 'screen': DeviceInfoScreen()},
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ✅ Notice Widget
class NoticeWidget extends StatelessWidget {
  const NoticeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.dynamicHeight(context, 0.05),
      decoration: BoxDecoration(
        border: const Border(bottom: BorderSide(color: AppColors.gradientEnd, width: 1)),
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(colors: [
          AppColors.gradientStart.withOpacity(0.35),
          Colors.white
        ]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: SizedBox(
              height: 20,
              child: Marquee(
                text: "Complete your KYC to avail bill payment and other services",
                style: const TextStyle(fontSize: 14),
                scrollAxis: Axis.horizontal,
                blankSpace: 20.0,
                velocity: 30.0,
                pauseAfterRound: const Duration(seconds: 1),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Image.asset("assets/icon_image/customer.png", width: 30),
        ],
      ),
    );
  }
}
