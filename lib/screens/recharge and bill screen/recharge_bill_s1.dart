import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/constants/app_colors.dart';
import 'package:payansh/constants/dimensions.dart';
import 'package:payansh/controllers/recharge_bill_controller.dart';
import 'package:payansh/screens/mobile_recharge/mobileRecharge1.dart';
import 'package:payansh/widgets/app_bar_image.dart';
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
                ? GestureDetector(
                    onTap: () {
                      Get.to(() => const Mobilerecharge1(),
                          transition: Transition.noTransition);
                    },
                    child: const MobileNumberFieldWidget(),
                  )
                : CustomTextField(
                    hintText: "Search Provider",
                    prefixIcon: const Icon(Icons.search),
                    onChanged: (val) => controller.searchQuery.value = val,
                  ),
            const SizedBox(height: 20),

            // Selected operator
            Obx(() {
              final selected = controller.selectedOperator.value;
              if (selected == null) {
                return Text("Select ${controller.getTypeName()} Operator");
              }
              return Row(
                children: [
                  Image.asset(
                    selected['image']!,
                    width: 30,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    selected['name']!,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              );
            }),
            const SizedBox(height: 10),

            // Operator list
            Expanded(
              child: Obx(() => ListView.builder(
                    itemCount: controller.filteredOperators.length,
                    itemBuilder: (context, index) {
                      final operator = controller.filteredOperators[index];
                      return ListTile(
                        title: Text(operator['name']!),
                        leading: Image.asset(operator['image']!, width: 40),
                        onTap: () {
                          controller.selectedOperator.value = {
                            'name': operator['name']!,
                            'image': operator['image']!,
                          };
                        },
                      );
                    },
                  )),
            ),
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
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.keyboardType,
    this.prefixIcon,
    this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppColors.drawerTextColor, width: 1),
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}
