import 'package:flutter/material.dart';
import 'custom_colors.dart';

class AppTextStyles {
  static const String fontFamily = 'HolyMidnight';

  static const TextStyle titleLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: CustomColors.iconColor,
  );

  static const TextStyle displayLarge = TextStyle(
    fontFamily: fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: CustomColors.iconColor,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    color: Colors.grey,
  );
}
