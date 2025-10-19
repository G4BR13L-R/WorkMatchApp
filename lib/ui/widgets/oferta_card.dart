import 'package:flutter/material.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/core/utils/format_helper.dart';
import 'package:work_match_app/ui/widgets/custom_button.dart';

class OfertaCard extends StatelessWidget {
  final String titulo;
  final double salario;
  final String dataInicio;
  final String dataFim;
  final bool isFinalizada;
  final bool isContratante;
  final VoidCallback? onEditar;
  final VoidCallback? onExcluir;
  final VoidCallback? onCandidatos;
  final VoidCallback? onAvaliar;

  const OfertaCard({
    super.key,
    required this.titulo,
    required this.salario,
    required this.dataInicio,
    required this.dataFim,
    required this.isFinalizada,
    required this.isContratante,
    this.onEditar,
    this.onExcluir,
    this.onCandidatos,
    this.onAvaliar,
  });

  @override
  Widget build(BuildContext context) {
    String dataInicio = FormatHelper.formatDateToBR(this.dataInicio);
    String dataFim = FormatHelper.formatDateToBR(this.dataFim);

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

          Text('Salário: R\$ ${salario.toStringAsFixed(2)}', style: AppTextStyles.subtitleOferta),
          Text('Data de Início: $dataInicio', style: AppTextStyles.subtitleOferta),
          Text('Data de Fim: $dataFim', style: AppTextStyles.subtitleOferta),
          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (isContratante && !isFinalizada) ...[
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

                SizedBox(width: 8),

                CustomButton(
                  text: 'Candidatos',
                  backgroundColor: AppColors.primary,
                  textStyle: AppTextStyles.buttonOferta,
                  onPressed: onCandidatos,
                ),
              ],

              if (isFinalizada) ...[
                CustomButton(
                  text: 'Avaliar',
                  backgroundColor: AppColors.primary,
                  textStyle: AppTextStyles.buttonOferta,
                  onPressed: onAvaliar,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
