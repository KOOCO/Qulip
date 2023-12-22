import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qulip/common/colors.dart';

class MySnackBar {
  static void errorSnackbar(String message) {
    Get.snackbar(
      'Note :',
      message,
      colorText: whiteTxt,
      icon: const Icon(Icons.error_outline, color: stdBlack),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.withOpacity(0.4),
    );
  }

  static void successSnackbar(String message) {
    Get.snackbar(
      'Alert :',
      message,
      colorText: whiteTxt,
      icon: const Icon(Icons.error_outline, color: Colors.white),
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green.withOpacity(0.5),
    );
  }
}
