// import 'package:flutter/material.dart';
// import 'package:payansh/constants/app_colors.dart';
// import 'package:payansh/screens/device_info.dart';
// import 'package:payansh/widgets/gradient_text.dart';
// import 'package:payansh/widgets/recharge_grid.dart';

// class RechargeBillPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Recharge & Bill Pays'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: const Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             GradientText('Recharge', style: TextStyle(fontSize: 22)),
//             SizedBox(height: 20),
//            RechargeGrid(iconData: [
//               {'image': 'assets/dashboard/bill.png', 'label': 'Bill\nPayment', 'screen': DeviceInfoScreen()},
//               {'image': 'assets/dashboard/mobile-recharge.png', 'label': 'Mobile\nRecharge', 'screen': DeviceInfoScreen()},
//               {'image': 'assets/dashboard/electricity-bill.png', 'label': 'Electricity', 'screen': DeviceInfoScreen()},
//               {'image': 'assets/dashboard/water-bill.png', 'label': 'Water\nBill', 'screen': DeviceInfoScreen()},
//               {'image': 'assets/dashboard/gas-cylinder.png', 'label': 'Gas\nPayment', 'screen': DeviceInfoScreen()},
//               {'image': 'assets/dashboard/bill.png', 'label': 'Bill\nPayment', 'screen': DeviceInfoScreen()},
//               {'image': 'assets/dashboard/mobile-recharge.png', 'label': 'Mobile\nRecharge', 'screen': DeviceInfoScreen()},
//               {'image': 'assets/dashboard/electricity-bill.png', 'label': 'Electricity', 'screen': DeviceInfoScreen()},
//               {'image': 'assets/dashboard/water-bill.png', 'label': 'Water\nBill', 'screen': DeviceInfoScreen()},
//               {'image': 'assets/dashboard/gas-cylinder.png', 'label': 'Gas\nPayment', 'screen': DeviceInfoScreen()}
//             ]),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/routes/routes.dart';
import 'package:payansh/widgets/app_bar.dart';
import '../utils/local_storage.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> logout() async {
    await LocalStorage.clearUserToken();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // AppBar
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 750,
            child: CustomAppBar(height: 50), // Increase height for overlap
          ),

          // Profile Section (Overlapping AppBar)
          Positioned(
            top: 80, // Adjust to control how much it overlaps
            left: 16,
            right: 16,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white,
                  child:
                      Text("TU", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Test User",
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
                Icon(Icons.notifications, color: Colors.white),
              ],
            ),
          ),
          // Main Content Below
          Positioned.fill(
              top: 180,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  NoticeWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 180, // Adjust height based on image size
                    child: PageView(
                      children: [
                        SvgPicture.asset(
                          "assets/banner/banner-1.svg",
                          fit: BoxFit.fill,
                        ),
                        SvgPicture.asset(
                          "assets/banner/sBanner-2.svg",
                          fit: BoxFit.fill,
                        ),
                        Image.asset("assets/banner/Banner-3.png",
                            fit: BoxFit.fill),
                        SvgPicture.asset("assets/banner/sBanner-4.svg",
                            fit: BoxFit.fill),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SvgPicture.asset(
                    "assets/banner/Link-Bank-Banner.svg",
                    width: 500, // Adjust width as needed
                    height: 170, // Adjust height as needed
                    fit: BoxFit
                        .fill, // Ensures the image covers the space properly
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset("assets/frame/Frame_recharge.svg"),
                      SvgPicture.asset("assets/frame/view_all.svg"),
                    ],
                  )
                ],
              ))
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
            border: Border(
                bottom: BorderSide(color: AppColors.gradientEnd, width: 1)),
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(colors: [
              AppColors.gradientStart.withOpacity(0.35),
              Colors.white
            ])),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: SizedBox(
                height: 20, // Adjust height as needed
                child: Marquee(
                  text:
                      "Complete your KYC to avail bill payment and other services",
                  style: TextStyle(fontSize: 14),
                  scrollAxis: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  blankSpace: 20.0,
                  velocity: 30.0,
                  pauseAfterRound: Duration(seconds: 1),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Image.asset(
              "assets/icon_image/customer.png",
              width: 30,
            ),
          ],
        ));
  }
}
