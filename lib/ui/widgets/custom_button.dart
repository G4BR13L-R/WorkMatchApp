import 'package:flutter/material.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final TextStyle textStyle;
  final VoidCallback? onPressed;

  const CustomButton({
    super.key,
    required this.text,
    this.backgroundColor = AppColors.primary,
    this.textStyle = AppTextStyles.button,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: onPressed,
      child: Text(text, style: textStyle),
    );
  }
}
