import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/controllers/recharge_bill_controller.dart';
import 'package:payansh/widgets/app_bar_image.dart';
import 'package:payansh/widgets/operator_selector.dart';
import 'package:payansh/widgets/recharge_mobile_field.dart';

class RechargeBillS1 extends StatelessWidget {
  final String billType;

  const RechargeBillS1({super.key, required this.billType});

  @override
  Widget build(BuildContext context) {
    final RechargeBillController controller =
        Get.put(RechargeBillController(billType: billType), tag: billType);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarImage(
        title: controller.getTitle(),
        height: Dimensions.dynamicHeight(context, 0.15),
      ),
      body: Padding(
        padding: EdgeInsets.all(Dimensions.dynamicHeight(context, 0.025)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            billType == 'mobile'
                ? const MobileNumberFieldWidget()
                : const CustomTextField(
                    hintText: "Search Provider",
                    prefixIcon: Icon(Icons.search),
                  ),
            const SizedBox(height: 20),
            Text("Select ${controller.getTypeName()} Operator",
                style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 10),
            Expanded(child: OperatorListWidget(controller: controller)),
          ],
        ),
      ),
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
