import 'package:flutter/material.dart';
import 'package:security/utils/custom_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool obscureText;
  final Color? iconColor;
  final Color? textColor;
  final Color? fillColor;
  final String? errorText; // Added errorText for validation messages

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.obscureText = false,
    this.iconColor,
    this.textColor,
    this.fillColor,
    this.errorText, // Error message
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define the border color
    Color borderColor = errorText == null ? CustomColors.accentColor : Colors.red;

    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: textColor ?? Colors.white),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          fontFamily: "Satoshi",
          color: textColor ?? Colors.white,
        ),

        filled: true,
        fillColor: fillColor ?? CustomColors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: borderColor, // Use the custom border color
            width: 1.5, // You can adjust the width of the border
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: borderColor, // Keep the border color when focused
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.red, // Set the border to red when there's an error
            width: 1.5,
          ),
        ),
        prefixIcon: Icon(icon, color: iconColor ?? CustomColors.iconColor),
        errorText: errorText, // Show error text if provided
      ),
    );
  }
}
