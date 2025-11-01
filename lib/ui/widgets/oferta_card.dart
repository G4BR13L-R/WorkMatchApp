import 'package:flutter/material.dart';
import 'package:work_match_app/core/models/status_model.dart';
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
  final StatusModel? status;
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
    this.status,
    this.onEditar,
    this.onExcluir,
    this.onCandidatos,
    this.onAvaliar,
  });

  @override
  Widget build(BuildContext context) {
    String dataInicio = FormatHelper.formatDateToBR(this.dataInicio);
    String dataFim = FormatHelper.formatDateToBR(this.dataFim);

    final styleCard = {1: AppColors.primary, 2: AppColors.accent, 3: AppColors.warning};

    return Container(
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: styleCard[status?.id] ?? AppColors.primary),
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

          if (status != null) ...[Text('Status: ${status!.descricao}', style: AppTextStyles.subtitleOferta)],

          const SizedBox(height: 16),

          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (isContratante) ...[
                Expanded(
                  child: CustomButton(
                    text: 'Candidatos',
                    backgroundColor: AppColors.accent,
                    textStyle: AppTextStyles.buttonOferta,
                    onPressed: onCandidatos,
                  ),
                ),

                if (!isFinalizada) ...[
                  SizedBox(width: 8),

                  Expanded(
                    child: CustomButton(
                      text: 'Editar',
                      backgroundColor: AppColors.primary,
                      textStyle: AppTextStyles.buttonOferta,
                      onPressed: onEditar,
                    ),
                  ),

                  SizedBox(width: 8),

                  Expanded(
                    child: CustomButton(
                      text: 'Excluir',
                      backgroundColor: AppColors.warning,
                      textStyle: AppTextStyles.buttonOferta,
                      onPressed: onExcluir,
                    ),
                  ),
                ],
              ],

              if (!isContratante && isFinalizada && status != null && status!.id == 2) ...[
                Expanded(
                  child: CustomButton(
                    text: 'Avaliar',
                    backgroundColor: AppColors.primary,
                    textStyle: AppTextStyles.buttonOferta,
                    onPressed: onAvaliar,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
