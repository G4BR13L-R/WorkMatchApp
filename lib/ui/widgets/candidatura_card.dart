import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:work_match_app/core/models/oferta_model.dart';
import 'package:work_match_app/core/models/status_model.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/core/utils/snackbar_helper.dart';
import 'package:work_match_app/ui/widgets/custom_button.dart';

class CandidaturaCard extends StatelessWidget {
  final String nome;
  final String telefone;
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
    required this.telefone,
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
    final styleCard = {1: AppColors.primary, 2: AppColors.accent, 3: AppColors.warning};

    return Container(
      decoration: BoxDecoration(
        color: AppColors.inputBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: styleCard[status.id] ?? AppColors.primary),
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
              if (!oferta.finalizada) ...[
                if (status.id != 2) ...[
                  Expanded(
                    child: CustomButton(
                      text: 'Contratar',
                      backgroundColor: AppColors.primary,
                      textStyle: AppTextStyles.buttonOferta,
                      onPressed: onContratar,
                    ),
                  ),
                ],

                if (status.id == 1) ...[const SizedBox(width: 8)],

                if (status.id != 3) ...[
                  Expanded(
                    child: CustomButton(
                      text: 'Reprovar',
                      backgroundColor: AppColors.warning,
                      textStyle: AppTextStyles.buttonOferta,
                      onPressed: onReprovar,
                    ),
                  ),
                ],
              ],

              if (oferta.finalizada) ...[
                Expanded(
                  child: CustomButton(
                    text: 'WhatsApp',
                    backgroundColor: AppColors.success,
                    textStyle: AppTextStyles.buttonOferta,
                    onPressed:
                        () => openWhatsapp(
                          telefone,
                          onError: () => SnackbarHelper.showError(context, 'Erro ao abrir o WhatsApp.'),
                        ),
                  ),
                ),

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

  Future<void> openWhatsapp(String telefone, {required VoidCallback onError}) async {
    final sanitized = telefone.replaceAll(RegExp(r'\D'), '');
    final Uri url = Uri.parse('https://wa.me/55$sanitized');

    try {
      final success = await launchUrl(url, mode: LaunchMode.platformDefault);
      if (!success) onError();
    } catch (e) {
      onError();
    }
  }
}
