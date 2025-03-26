import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:marquee/marquee.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/controllers/slider_controller.dart';
import 'package:payansh/routes/routes.dart';
import 'package:payansh/screens/device_info.dart';
import 'package:payansh/screens/notifications.dart';
import 'package:payansh/services/api_service.dart';
import 'package:payansh/widgets/app_bar.dart';
import 'package:payansh/widgets/bottom_drawer.dart';
import 'package:payansh/widgets/gradient_text.dart';
import 'package:payansh/widgets/recharge_grid.dart';
import 'package:payansh/screens/drawer_navigation.dart';
import 'package:payansh/screens/offers.dart';
import 'package:shimmer/shimmer.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
//   final GlobalKey<SliderDrawerState> _drawerKey =
//       GlobalKey<SliderDrawerState>();
//   Future<void> logout() async {
//     await LocalStorage.clearUserToken();
//     Get.offAllNamed(AppRoutes.login);
//     _HomeScreenState createState() => _HomeScreenState();
//   }

//   int _bottomNavIndex = 0; // Default active index

//   late AnimationController _fabAnimationController;
//   late Animation<double> fabAnimation;

//   final iconList = <IconData>[
//     Icons.home_outlined, // Home Icon
//     Icons.history_outlined, // History Icon
//   ];

//   @override
//   void initState() {
//     super.initState();

//     _fabAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );

//     fabAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _fabAnimationController, curve: Curves.easeIn),
//     );

//     Future.delayed(const Duration(milliseconds: 500), () {
//       _fabAnimationController.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _fabAnimationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//             //  body: _g etBody(),
//                       floatingActionButton: FloatingActionButton(
//                         onPressed: () {},
//                         shape: const CircleBorder(),
//                         backgroundColor: Colors.blue,
//                         child: const Icon(Icons.add, color: Colors.white),
//                       ),
//         body:
//         SliderDrawer(
//             key: _drawerKey,
//             slider: DrawerNavigation(), // Sidebar Navigation
//             child: SafeArea(
//                 child: Column(children: [
//               // ✅ Restored Previous AppBar
//               Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                   child: Row(children: [
//                     GestureDetector(
//                       onTap: () {
//                         _drawerKey.currentState?.toggle(); // Open Sidebar
//                       },
//                       child: const CircleAvatar(
//                         radius: 24,
//                         backgroundColor: Colors.white,
//                         child: Text("TU",
//                             style: TextStyle(fontWeight: FontWeight.bold)),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     const Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Test User",
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Text(
//                           "Welcome to Payance!",
//                           style: TextStyle(color: Colors.grey, fontSize: 14),
//                         ),
//                       ],
//                     ),
//                     const Spacer(),
//                     IconButton(
//                       icon:
//                           const Icon(Icons.notifications, color: Colors.black),
//                       onPressed: () {
//                         // Notification Logic
//                       },

//                       // floatingActionButtonLocation:
//                       //     FloatingActionButtonLocation.centerDocked,

//                     )
//                   ])),
//                   _getBody()
//             ]),
//             )),
//             // extendBody: true,
//                       // body: _getBody(),
//                       // floatingActionButton: FloatingActionButton(
//                       //   onPressed: () {},
//                       //   shape: const CircleBorder(),
//                       //   backgroundColor: Colors.blue,
//                       //   child: const Icon(Icons.add, color: Colors.white),
//                       // ),
//              bottomNavigationBar: Container(
//                         height: 80, // Increased height of bottom bar
//                         padding: const EdgeInsets.only(
//                             bottom: 0), // Padding for better spacing
//                         child: AnimatedBottomNavigationBar(
//                           icons: iconList,
//                           activeIndex: _bottomNavIndex,
//                           gapLocation: GapLocation.center,
//                           notchSmoothness: NotchSmoothness.defaultEdge,
//                           leftCornerRadius: 18,
//                           rightCornerRadius: 18,
//                           backgroundColor: Colors.blueGrey.shade900,
//                           activeColor: Colors.blueAccent,
//                           inactiveColor: Colors.grey,
//                           iconSize: 30, // Increased icon size
//                           onTap: (index) =>
//                               setState(() => _bottomNavIndex = index),
//                         ),
//                       ),
//                       );
//   }

//   Widget _getBody() {
//     switch (_bottomNavIndex) {
//       case 1:
//         return const SettingsScreen();
//       default:
//         return _buildHomeContent();
//     }
//   }

// }

// // ✅ Notice Widget
class NoticeWidget extends StatelessWidget {
  const NoticeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.dynamicHeight(context, 0.05),
      decoration: BoxDecoration(
        border: const Border(
            bottom: BorderSide(color: AppColors.gradientEnd, width: 1)),
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
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
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
          ),
          const SizedBox(width: 10),
          Image.asset("assets/icon_image/customer.png", width: 30),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final SliderController sliderController = Get.put(SliderController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _bottomNavIndex = 0;

  late Future<Map<String, dynamic>?> _userProfileFuture;

  final iconList = <IconData>[
    HugeIcons.strokeRoundedHome09,
    Icons.history_outlined,
  ];

  final List<String> iconLabels = ["Home", "History"];

  late AnimationController _fabAnimationController;
  late Animation<double> fabAnimation;

  @override
  void initState() {
    _userProfileFuture = ApiService.getUserProfile();

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
      key: _scaffoldKey,
      drawer: DrawerNavigation(), // Drawer added here
      // appBar: AppBar(
      //   title: const Text("Combined Screen"),
      //   leading: IconButton(
      //     icon: const Icon(Icons.menu),
      //     onPressed: () {
      //       _scaffoldKey.currentState?.openDrawer();
      //     },
      //   ),
      // ),

      extendBody: true,
      body: _getBody(),
      floatingActionButton: const BottomNavWithDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        // margin: EdgeInsets.only(left: 10),
        height: Dimensions.dynamicWidth(
            context, 0.22), // Increased height to accommodate labels
        child: AnimatedBottomNavigationBar.builder(
          itemCount: iconList.length,
          tabBuilder: (index, isActive) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // SizedBox(height: Dimensions.dynamicHeight(context, 0.009),),
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: isActive
                          ? [AppColors.gradientEnd, AppColors.gradientStart]
                          : [Colors.grey, Colors.grey],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                    ).createShader(bounds);
                  },
                  child: Icon(
                    iconList[index],
                    size: Dimensions.dynamicWidth(context, 0.06),
                    color: Colors.white, // Apply ShaderMask on white color
                  ),
                ),
                if (isActive) // Show label only for the active icon
                  Padding(
                      padding: EdgeInsets.only(
                          top: Dimensions.dynamicHeight(context, 0.00)),
                      child:
                          // GradientText(
                          //   iconLabels[index],
                          //   style: TextStyle(
                          //     fontSize: Dimensions.dynamicWidth(context, 0.034),
                          //     fontWeight: FontWeight.w500,
                          //     color: Colors.white,
                          //   ),
                          // )
                          Text(
                        iconLabels[index],
                        style: TextStyle(
                          fontSize: Dimensions.dynamicWidth(context, 0.034),
                          fontWeight: FontWeight.w500,
                          color: AppColors.gradientEnd,
                        ),
                      )),
              ],
            );
          },
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.defaultEdge,
          leftCornerRadius: 10,
          rightCornerRadius: 10,
          backgroundColor: Color(0xff0B2239),
          onTap: (index) => setState(() => _bottomNavIndex = index),
        ),
      ),
    );
  }

  Widget _getBody() {
    switch (_bottomNavIndex) {
      case 1:
        return const Offers();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return Column(
      children: [
        Stack(
          children: [
            SizedBox(
              height: 130, // Fix the height of the CustomAppBar
              child: CustomAppBar(
                height: 50,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16, top: 30),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState?.openDrawer();
                        },
                        child: const CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FutureBuilder<Map<String, dynamic>?>(
                              future: _userProfileFuture,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  );
                                } else if (snapshot.hasError ||
                                    !snapshot.hasData) {
                                  return const Center(
                                      child: Text("Failed to load profile"));
                                }

                                final userData = snapshot.data!;
                                return Text(
                                  userData['name'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                );
                              }),
                          const Text(
                            "Welcome to Payansh!",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Get.to(Notifications());
                        },
                        child: const Icon(Icons.notifications,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const NoticeWidget(),
                  SizedBox(height: Dimensions.dynamicHeight(context, 0.01)),
                  // SizedBox(
                  //   height: 180,
                  //   child: PageView(
                  //     children: [
                  //       FittedBox(
                  //         fit: BoxFit.contain,
                  //         child: Image.asset("assets/banner/slider1.png"),
                  //       ),
                  //       FittedBox(
                  //         fit: BoxFit.contain,
                  //         child: Image.asset("assets/banner/slider3.png"),
                  //       ),
                  //       FittedBox(
                  //         fit: BoxFit.contain,
                  //         child: Image.asset("assets/banner/slider2.png"),
                  //       ),
                  //       FittedBox(
                  //         fit: BoxFit.contain,
                  //         child: Image.asset("assets/banner/slider4.png"),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  CarouselSlider(
                    options: CarouselOptions(
                      // height: Dimensions.dynamicHeight(context, 0.25),
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      enlargeCenterPage: true,
                      viewportFraction: 1.0, // Ensure it takes the full width

                      onPageChanged: (index, reason) {
                        sliderController.updateIndex(index);
                      },
                    ),
                    items: sliderController.bannerImages.map((imagePath) {
                      return Image.asset(imagePath);
                    }).toList(),
                  ),
                  // const SizedBox(height: 10),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: SvgPicture.asset(
                      "assets/banner/Link-Bank-Banner.svg",
                      width: MediaQuery.of(context).size.width,
                      // height: 170,
                      // fit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset("assets/icon/RechargeVector.svg"),
                          const SizedBox(width: 10),
                          const GradientText('Recharge & Bill Pays',
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     Get.toNamed(AppRoutes.home);
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     minimumSize: Size(
                      //         Dimensions.dynamicWidth(context, 0.05),
                      //         Dimensions.dynamicHeight(context, 0.03)),
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(3)),
                      //     backgroundColor: AppColors.gradientStart,
                      //   ),
                      //   child: Text("View All",
                      //       style: TextStyle(color: Colors.white, fontSize: 6)),
                      //   // SizedBox(
                      //   //   width: 10,
                      //   // ),
                      //   // Icon(
                      //   //   Icons.arrow_forward,
                      //   //   color: Colors.white,
                      //   // ),
                      // ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.recharge);
                        },
                        child: Container(
                            width: Dimensions.dynamicWidth(context, 0.2),
                            height: Dimensions.dynamicHeight(context, 0.035),
                            decoration: BoxDecoration(
                              color: AppColors.gradientStart,
                              borderRadius: BorderRadius.circular(3),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "View All",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: Dimensions.dynamicWidth(context, 0.03),
                                ),
                              ],
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const RechargeGrid(
                    iconData: [
                      {
                        'image': 'assets/dashboard/mobile-recharge.png',
                        'label': 'Mobile\nRecharge',
                        'screen': DeviceInfoScreen()
                      },
                      {
                        'image': 'assets/dashboard/dth.png',
                        'label': 'DTH\nRecharge',
                        'screen': DeviceInfoScreen()
                      },
                      {
                        'image': 'assets/dashboard/water-bill.png',
                        'label': 'Water\nBill',
                        'screen': const DeviceInfoScreen()
                      },
                      {
                        'image': 'assets/dashboard/electricity-bill.png',
                        'label': 'Electricity\nBill',
                        'screen': DeviceInfoScreen()
                      },
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/icon/travel.svg"),
                      const SizedBox(width: 10),
                      const GradientText('Travelling',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.w500)),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const RechargeGrid(
                    iconData: [
                      {
                        'image': 'assets/dashboard/flight1.png',
                        'label': 'Flight Booking',
                        'screen': DeviceInfoScreen()
                      },
                      {
                        'image': 'assets/dashboard/hotel.png',
                        'label': 'Hotel Booking',
                        'screen': DeviceInfoScreen()
                      },
                    ],
                  ),
                  const SizedBox(height: 20),

                  GradientText("Flight & Hotel Booking Offers",
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.w500)),
                  // const SizedBox(height: Dime),

                  CarouselSlider(
                    options: CarouselOptions(
                      // height: Dimensions.dynamicHeight(context, 0.25),
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 2),
                      enlargeCenterPage: true,
                      viewportFraction: 1.0, // Ensure it takes the full width

                      onPageChanged: (index, reason) {
                        sliderController.updateIndex(index);
                      },
                    ),
                    items: sliderController.flightOffer.map((imagePath) {
                      return Image.asset(imagePath);
                    }).toList(),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
