import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/routes/routes.dart';
import 'package:payansh/screens/device_info.dart';
import 'package:payansh/screens/offers.dart';
import 'package:payansh/screens/setting.dart';
import 'package:payansh/widgets/app_bar.dart';
import 'package:payansh/widgets/gradient_text.dart';
import 'package:payansh/widgets/recharge_grid.dart';
import '../utils/local_storage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _bottomNavIndex = 0; // Default active index

  late AnimationController _fabAnimationController;
  late Animation<double> fabAnimation;

  final iconList = <IconData>[
    Icons.home_outlined, // Home Icon
    Icons.history_outlined, // History Icon
  ];

  @override
  void initState() {
    super.initState();

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fabAnimationController, curve: Curves.easeIn),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      _fabAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _getBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 80, // Increased height of bottom bar
        padding: const EdgeInsets.only(bottom: 0), // Padding for better spacing
        child: AnimatedBottomNavigationBar(
          icons: iconList,
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
          leftCornerRadius: 18,
          rightCornerRadius: 18,
          backgroundColor: Colors.blueGrey.shade900,
          activeColor: Colors.blueAccent,
          inactiveColor: Colors.grey,
          iconSize: 30, // Increased icon size
          onTap: (index) => setState(() => _bottomNavIndex = index),
        ),
      ),
    );
  }

  Widget _getBody() {
    switch (_bottomNavIndex) {
      case 1:
        return const SettingsScreen();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          bottom: Dimensions.dynamicHeight(context, 0.83),
          child: CustomAppBar(height: 50),
        ),
        Positioned(
          top: 80,
          left: 16,
          right: 16,
          child: Row(
            children: [
              const CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Icon(Icons.person),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Hiii...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Welcome to Payance!",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.notifications, color: Colors.white),
            ],
          ),
        ),
        Positioned.fill(
          top: 180,
          left: 20,
          right: 20,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const NoticeWidget(),
                const SizedBox(height: 20),
                SizedBox(
                  height: 180,
                  child: PageView(
                    children: [
                      SvgPicture.asset("assets/banner/banner-1.svg",
                          fit: BoxFit.fill),
                      SvgPicture.asset("assets/banner/sBanner-2.svg",
                          fit: BoxFit.fill),
                      Image.asset("assets/banner/Banner-3.png",
                          fit: BoxFit.fill),
                      SvgPicture.asset("assets/banner/sBanner-4.svg",
                          fit: BoxFit.fill),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => Get.to(() => Offers()),
                  child: SvgPicture.asset("assets/banner/Link-Bank-Banner.svg",
                      width: 500, height: 170, fit: BoxFit.fill),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset("assets/icon/RechargeVector.svg"),
                        SizedBox(
                          width: 10,
                        ),
                        GradientText('Recharge & Bill Pays',
                            style: TextStyle(fontSize: 19)),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            "View All",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Icon(Icons.arrow_forward)
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: AppColors.gradientStart),
                    )
                  ],
                ),
                RechargeGrid(iconData: [
                  {
                    'image': 'assets/dashboard/bill.png',
                    'label': 'Bill\nPayment',
                    'screen': DeviceInfoScreen()
                  },
                  {
                    'image': 'assets/dashboard/mobile-recharge.png',
                    'label': 'Mobile\nRecharge',
                    'screen': DeviceInfoScreen()
                  },
                  {
                    'image': 'assets/dashboard/electricity-bill.png',
                    'label': 'Electricity',
                    'screen': DeviceInfoScreen()
                  },
                  {
                    'image': 'assets/dashboard/water-bill.png',
                    'label': 'Water\nBill',
                    'screen': DeviceInfoScreen()
                  },
                ]),
                _buildSectionHeader("Travelling", Icons.travel_explore),
                RechargeGrid(iconData: [
                  {
                    'image': 'assets/dashboard/bill.png',
                    'label': 'Bill\nPayment',
                    'screen': DeviceInfoScreen()
                  },
                  {
                    'image': 'assets/dashboard/mobile-recharge.png',
                    'label': 'Mobile\nRecharge',
                    'screen': DeviceInfoScreen()
                  },
                ]),
                SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.amber),
              const SizedBox(width: 10),
              GradientText(title, style: const TextStyle(fontSize: 19)),
            ],
          ),
        ],
      ),
    );
  }
}

class NoticeWidget extends StatelessWidget {
  const NoticeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.dynamicHeight(context, 0.05),
      decoration: BoxDecoration(
        border:
            Border(bottom: BorderSide(color: AppColors.gradientEnd, width: 1)),
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            colors: [AppColors.gradientStart.withOpacity(0.35), Colors.white]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: SizedBox(
              height: 20,
              child: Marquee(
                text:
                    "Complete your KYC to avail bill payment and other services",
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
