import 'package:flutter/material.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/ui/widgets/custom_button.dart';

class CandidaturaCard extends StatelessWidget {
  final String nome;
  final double salario;
  final String cidade;
  final String estado;
  final String status;
  final VoidCallback onContratar;
  final VoidCallback onReprovar;

  const CandidaturaCard({
    super.key,
    required this.nome,
    required this.salario,
    required this.cidade,
    required this.estado,
    required this.status,
    required this.onContratar,
    required this.onReprovar,
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
          Text(nome, style: AppTextStyles.titleOferta),
          const SizedBox(height: 4),

          Text("$cidade - $estado", style: AppTextStyles.subtitleOferta),
          Text("Pretensão: R\$ $salario", style: AppTextStyles.subtitleOferta),
          Text("Status: $status", style: AppTextStyles.subtitleOferta),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Contratar',
                  backgroundColor: AppColors.primary,
                  textStyle: AppTextStyles.buttonOferta,
                  onPressed: onContratar,
                ),
              ),

              const SizedBox(width: 8),
              
              Expanded(
                child: CustomButton(
                  text: 'Reprovar',
                  backgroundColor: AppColors.warning,
                  textStyle: AppTextStyles.buttonOferta,
                  onPressed: onReprovar,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
