import 'package:flutter/material.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/ui/widgets/custom_button.dart';

Future<String?> customInputDialog(
  BuildContext context, {
  required String title,
  required String label,
  String? initialValue,
}) async {
  final TextEditingController controller = TextEditingController(text: initialValue ?? '');

  final resultado = await showDialog<String>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(title, style: AppTextStyles.titleOferta),
        backgroundColor: AppColors.inputBackground,
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: AppTextStyles.subtitleOferta,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: AppTextStyles.subtitleOferta,
            filled: true,
            fillColor: Colors.white12,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        actions: [
          CustomButton(
            text: 'Cancelar',
            backgroundColor: AppColors.warning,
            textStyle: AppTextStyles.buttonOferta,
            onPressed: () => Navigator.of(context).pop(null),
          ),
          CustomButton(
            text: 'Confirmar',
            backgroundColor: AppColors.primary,
            textStyle: AppTextStyles.buttonOferta,
            onPressed: () {
              Navigator.of(context).pop(controller.text.trim());
            },
          ),
        ],
      );
    },
  );

  return resultado;
}
