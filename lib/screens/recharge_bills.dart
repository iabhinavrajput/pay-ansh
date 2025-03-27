import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
              left: 56, // Increased spacing from back button
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
              left: 16,
              bottom: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Positioned(
              right: 16,
              bottom: 20,
              child: SvgPicture.asset(
                'assets/logo/Bharat_Connect.svg',
                height: Dimensions.dynamicHeight(context, 0.03),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText('Recharge', style: TextStyle(fontSize: 16)),
              SizedBox(height: Dimensions.dynamicHeight(context, 0.015)),
              RechargeGrid(iconData: [
                {
                  'image': 'assets/dashboard/mobile-recharge.png',
                  'label': 'Mobile\nRecharge',
                  // 'screen': DeviceInfoScreen()
                },
                {
                  'image': 'assets/dashboard/dth.png',
                  'label': 'DTH\nRecharge',
                  // 'screen': DeviceInfoScreen()
                },
                {
                  'image': 'assets/dashboard/router.png',
                  'label': 'Broad\nband',
                  // 'screen': DeviceInfoScreen()
                },
                {
                  'image': 'assets/dashboard/fast-tag.png',
                  'label': 'Fastag\nRecharge',
                  // 'screen': DeviceInfoScreen()
                },
              ]),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.01),
              ),
              GradientText('Utility bills', style: TextStyle(fontSize: 16)),
              SizedBox(height: Dimensions.dynamicHeight(context, 0.015)),
              RechargeGrid(iconData: [
                {
                  'image': 'assets/dashboard/bill.png',
                  'label': 'Postpaid\nMobile',
                  'screen': const DeviceInfoScreen()
                },
                {
                  'image': 'assets/dashboard/landline.png',
                  'label': 'Landline\nBill',
                  'screen': const DeviceInfoScreen()
                },
                {
                  'image': 'assets/dashboard/electricity-bill.png',
                  'label': 'Electricity\nBill',
                  'screen': const DeviceInfoScreen()
                },
                {
                  'image': 'assets/dashboard/water-bill.png',
                  'label': 'Water\nBill',
                  'screen': const DeviceInfoScreen()
                },
                {
                  'image': 'assets/dashboard/gas-cylinder.png',
                  'label': 'Gas\nBooking',
                  'screen': const DeviceInfoScreen()
                },
                {
                  'image': 'assets/dashboard/education.png',
                  'label': 'Fee',
                  'screen': const DeviceInfoScreen()
                },
                {
                  'image': 'assets/dashboard/piped-gas-bill.png',
                  'label': 'Piped\nGas',
                  'screen': const DeviceInfoScreen()
                }
              ]),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.01),
              ),
              GradientText('Finance & Tax', style: TextStyle(fontSize: 16)),
              SizedBox(height: Dimensions.dynamicHeight(context, 0.015)),
              RechargeGrid(iconData: [
                {
                  'image': 'assets/dashboard/insurance-1.png',
                  'label': 'Lic /\nInsurance',
                  'screen': const DeviceInfoScreen()
                },
                {
                  'image': 'assets/dashboard/loan.png',
                  'label': 'Loan\nPayOff',
                  'screen': const DeviceInfoScreen()
                },
                {
                  'image': 'assets/dashboard/credit-cards.png',
                  'label': 'Credit\nCards',
                  'screen': const DeviceInfoScreen()
                },
                {
                  'image': 'assets/dashboard/tax.png',
                  'label': 'Muncipal\nTax',
                  'screen': const DeviceInfoScreen()
                },
              ]),
              SizedBox(
                height: Dimensions.dynamicHeight(context, 0.01),
              ),
              GradientText('More', style: TextStyle(fontSize: 16)),
              SizedBox(height: Dimensions.dynamicHeight(context, 0.015)),
              RechargeGrid(iconData: [
                {
                  'image': 'assets/dashboard/Subscription.png',
                  'label': 'Sub\nscription',
                  'screen': const DeviceInfoScreen()
                },
                {
                  'image': 'assets/dashboard/housing.png',
                  'label': 'Housing\nSociety',
                  'screen': const DeviceInfoScreen()
                },
                {
                  'image': 'assets/dashboard/Rent-pay.png',
                  'label': 'Rent\nPay',
                  'screen': const DeviceInfoScreen()
                },

              ])
            ],
          ),
        ),
      ),
    );
  }
}
