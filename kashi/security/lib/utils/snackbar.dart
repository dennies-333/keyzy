import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtil {
  // Function to show a customizable snackbar
  static void showErrorSnackBar(
    String heading,
    String message,
    Color color,
    Color textColor, {
    SnackPosition snackPosition = SnackPosition.BOTTOM, // Default to bottom
  }) {
    Get.snackbar(
      heading,
      message,
      backgroundColor: color,
      colorText: textColor,
      snackPosition: snackPosition,
      margin: EdgeInsets.all(16),
      borderRadius: 10,
      duration: Duration(seconds: 1),
    );
  }
}
