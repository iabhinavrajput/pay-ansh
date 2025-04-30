import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payansh/controllers/recharge_bill_controller.dart';

class OperatorListWidget extends StatelessWidget {
  final RechargeBillController controller;

  const OperatorListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.operators.length,
        itemBuilder: (context, index) {
          final operator = controller.operators[index];
          return ListTile(
            leading: Image.asset(operator['image']!, width: 40, height: 40),
            title: Text(operator['name']!),
            onTap: () {
              // Handle selection
              Get.snackbar("Selected", operator['name']!);
            },
          );
        },
      );
    });
  }
}
