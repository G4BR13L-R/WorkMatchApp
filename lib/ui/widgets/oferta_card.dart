import 'package:flutter/material.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/ui/widgets/custom_button.dart';

class OfertaCard extends StatelessWidget {
  final String titulo;
  final String descricao;
  final VoidCallback onEditar;
  final VoidCallback onExcluir;

  const OfertaCard({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.onEditar,
    required this.onExcluir,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: AppTextStyles.titleOferta),
          const SizedBox(height: 8),

          Text(
            descricao.length > 75 ? '${descricao.substring(0, 75)}...' : descricao,
            style: AppTextStyles.subtitleOferta,
          ),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomButton(
                text: 'Editar',
                backgroundColor: AppColors.primary,
                textStyle: AppTextStyles.buttonOferta,
                onPressed: onEditar,
              ),

              SizedBox(width: 8),

              CustomButton(
                text: 'Excluir',
                backgroundColor: AppColors.warning,
                textStyle: AppTextStyles.buttonOferta,
                onPressed: onExcluir,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
