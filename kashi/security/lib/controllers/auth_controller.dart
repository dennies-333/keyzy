import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:security/services/local_storage_service.dart';
import 'package:security/views/login_view.dart';
import 'package:security/utils/custom_colors.dart'; // Assuming you have custom colors

class AuthController extends GetxController {
  Future<void> logout() async {
    // Show a confirmation dialog
    bool shouldLogout = await _showLogoutDialog();
    
    // If the user confirms, proceed with logout
    if (shouldLogout) {
      await LocalStorage.clearAllValues();
      Get.offAll(() => LoginView());
    }
  }

  // Method to show the logout confirmation dialog
  Future<bool> _showLogoutDialog() async {
    return await Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: CustomColors.primaryColor, // Using custom background color
        title: Text(
          'Logout',
          style: TextStyle(
            color: CustomColors.secondaryColor, // Title text color from custom colors
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: TextStyle(
            color: Colors.white, // Text color for content
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false), // Close the dialog and return false (cancel logout)
            style: TextButton.styleFrom(
              foregroundColor: CustomColors.accentColor, // Custom cancel button color
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Get.back(result: true), // Confirm logout
            style: TextButton.styleFrom(
              foregroundColor: Colors.red, // Custom logout button color
            ),
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
