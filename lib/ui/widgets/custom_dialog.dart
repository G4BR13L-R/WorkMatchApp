import 'package:flutter/material.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/ui/widgets/custom_button.dart';

Future<bool> CustomDialog(BuildContext context, String title, String content, {String type = 'confirm'}) async {
  final bool isDelete = type == 'delete';

  final Color yesColor = isDelete ? AppColors.warning : AppColors.primary;
  final Color noColor = isDelete ? AppColors.primary : AppColors.warning;

  final resultado = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        title: Text(title, style: AppTextStyles.titleOferta),
        content: Text(content, style: AppTextStyles.subtitleOferta),
        backgroundColor: AppColors.inputBackground,
        actions: [
          CustomButton(
            text: 'Cancelar',
            onPressed: () => Navigator.of(context).pop(false),
            backgroundColor: noColor,
            textStyle: AppTextStyles.buttonOferta,
          ),
          CustomButton(
            text: isDelete ? 'Excluir' : 'Confirmar',
            onPressed: () => Navigator.of(context).pop(true),
            backgroundColor: yesColor,
            textStyle: AppTextStyles.buttonOferta,
          ),
        ],
      );
    },
  );

  return resultado ?? false;
}
