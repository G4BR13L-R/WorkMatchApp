import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
    letterSpacing: 1.2,
  );

  static const TextStyle titleOferta = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
    letterSpacing: 1.2,
  );

  static const TextStyle subtitle = TextStyle(fontSize: 16, color: AppColors.textLight);

  static const TextStyle subtitleOferta = TextStyle(fontSize: 14, color: AppColors.textLight);

  static const TextStyle button = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black);

  static const TextStyle buttonOferta = TextStyle(fontSize: 14, color: Colors.black);
}
