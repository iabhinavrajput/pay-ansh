import 'package:flutter/material.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/screens/device_info.dart';
import 'package:payansh/widgets/app_bar.dart';
import 'package:payansh/widgets/gradient_text.dart';
import 'package:payansh/widgets/recharge_grid.dart';

class RechargeBillPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Stack(
          children: [
            const CustomAppBar(height: 70),
            const Positioned(
              left: 16,
              bottom: 20,
              child: Text(
                'Recharge & Bill Pays',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            Positioned(
              right: 16,
              bottom: 15,
              child: Image.asset(
                'assets/dashboard/bill.png',
                height: 40,
              ),
            ),
          ],
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText('Recharge', style: TextStyle(fontSize: 22)),
              SizedBox(height: 20),
              RechargeGrid(iconData: [
                {'image': 'assets/dashboard/bill.png', 'label': 'Bill\nPayment', 'screen': DeviceInfoScreen()},
                {'image': 'assets/dashboard/mobile-recharge.png', 'label': 'Mobile\nRecharge', 'screen': DeviceInfoScreen()},
                {'image': 'assets/dashboard/electricity-bill.png', 'label': 'Electricity\nBill', 'screen': DeviceInfoScreen()},
                {'image': 'assets/dashboard/water-bill.png', 'label': 'Water\nBill', 'screen': DeviceInfoScreen()},
                {'image': 'assets/dashboard/gas-cylinder.png', 'label': 'Gas\nPayment', 'screen': DeviceInfoScreen()}
              ]),
              SizedBox(height: 20),
              GradientText('Recharge', style: TextStyle(fontSize: 22)),
              SizedBox(height: 20),
              RechargeGrid(iconData: [
                {'image': 'assets/dashboard/bill.png', 'label': 'Bill\nPayment', 'screen': DeviceInfoScreen()},
                {'image': 'assets/dashboard/mobile-recharge.png', 'label': 'Mobile\nRecharge', 'screen': DeviceInfoScreen()},
                {'image': 'assets/dashboard/electricity-bill.png', 'label': 'Electricity\nBill', 'screen': DeviceInfoScreen()},
                {'image': 'assets/dashboard/water-bill.png', 'label': 'Water\nBill', 'screen': DeviceInfoScreen()},
                {'image': 'assets/dashboard/gas-cylinder.png', 'label': 'Gas\nPayment', 'screen': DeviceInfoScreen()}
              ])
            ],
          ),
        ),
      ),
    );
  }
}