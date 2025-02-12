import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackbar({required String title, required String message, required bool isSuccess}) {
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: isSuccess ? Colors.green : Colors.redAccent,
    colorText: Colors.white,
    margin: const EdgeInsets.all(8),
    borderRadius: 8,
    duration: const Duration(seconds: 3),
  );
}
