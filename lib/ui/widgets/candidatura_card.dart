import 'package:flutter/material.dart';
import 'package:work_match_app/core/models/oferta_model.dart';
import 'package:work_match_app/core/models/status_model.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/ui/widgets/custom_button.dart';

class CandidaturaCard extends StatelessWidget {
  final String nome;
  final double salario;
  final String cidade;
  final String estado;
  final StatusModel status;
  final OfertaModel oferta;
  final VoidCallback? onContratar;
  final VoidCallback? onReprovar;
  final VoidCallback? onAvaliar;

  const CandidaturaCard({
    super.key,
    required this.nome,
    required this.salario,
    required this.cidade,
    required this.estado,
    required this.status,
    required this.oferta,
    this.onContratar,
    this.onReprovar,
    this.onAvaliar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: status.id == 1 ? AppColors.primary : AppColors.accent),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(nome, style: AppTextStyles.titleOferta),
          const SizedBox(height: 4),

          Text("Status: ${status.descricao}", style: AppTextStyles.subtitleOferta),
          Text("Pretensão: R\$ ${salario.toStringAsFixed(2)}", style: AppTextStyles.subtitleOferta),
          Text("Localização: $cidade - $estado", style: AppTextStyles.subtitleOferta),
          const SizedBox(height: 16),

          Row(
            children: [
              if (status.id == 1) ...[
                Expanded(
                  child: CustomButton(
                    text: 'Contratar',
                    backgroundColor: AppColors.primary,
                    textStyle: AppTextStyles.buttonOferta,
                    onPressed: onContratar,
                  ),
                ),
                const SizedBox(width: 8),
              ],

              if (!oferta.finalizada) ...[
                Expanded(
                  child: CustomButton(
                    text: 'Reprovar',
                    backgroundColor: AppColors.warning,
                    textStyle: AppTextStyles.buttonOferta,
                    onPressed: onReprovar,
                  ),
                ),
              ],

              if (oferta.finalizada) ...[
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
