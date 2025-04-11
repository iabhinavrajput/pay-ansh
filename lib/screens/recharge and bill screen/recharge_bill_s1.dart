import 'package:flutter/material.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/theme/custom_themes/text_theme.dart';
import 'package:payansh/widgets/app_bar_image.dart';
import 'package:payansh/widgets/custom_text_field.dart';
import 'package:payansh/widgets/mobile_field.dart';
import 'package:payansh/widgets/recharge_mobile_field.dart';

class RechargeBillS1 extends StatelessWidget {
  final String billType;

  const RechargeBillS1({
    super.key,
    required this.billType,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarImage(
        title: _getTitle(billType),
        height: Dimensions.dynamicHeight(context, 0.15),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.dynamicHeight(context, 0.025)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (billType == 'mobile')
              _buildMobileNumberField(context)
            else
              _buildSearchField(context),
            const SizedBox(height: 20),
            // Add rest of the common UI below
            Text(
              'More fields for $billType go here...',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  String _getTitle(String type) {
    switch (type) {
      case 'mobile':
        return 'Mobile Recharge';
      case 'electricity':
        return 'Electricity Bill';
      case 'loan':
        return 'Loan Repayment';
      case 'subscription':
        return 'Subscription Fee';
      default:
        return 'Recharge/Bill';
    }
  }

  Widget _buildMobileNumberField(BuildContext context) {
    return const MobileNumberFieldWidget();
  }

  Widget _buildSearchField(BuildContext context) {
    return const CustomTextField(
      hintText: "Search Provider",
      prefixIcon: Icon(Icons.search),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.keyboardType,
    this.prefixIcon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
