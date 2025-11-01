import 'package:flutter/material.dart';
import 'package:work_match_app/core/controllers/contratado/oferta_controller.dart';
import 'package:work_match_app/core/models/oferta_model.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/core/utils/snackbar_helper.dart';
import 'package:work_match_app/ui/widgets/oferta_card.dart';

class OfertaFinalizadaContratado extends StatefulWidget {
  const OfertaFinalizadaContratado({super.key});

  @override
  State<OfertaFinalizadaContratado> createState() => _OfertaFinalizadaContratadoState();
}

class _OfertaFinalizadaContratadoState extends State<OfertaFinalizadaContratado> {
  final OfertaController _ofertaController = OfertaController();

  List<OfertaModel> _ofertas = [];
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    _loadOfertas();
  }

  Future<void> _loadOfertas() async {
    setState(() => _isFetching = true);

    try {
      final ofertas = await _ofertaController.index(status: true); // Ofertas finalizadas.

      setState(() => _ofertas = ofertas);
    } catch (e) {
      if (mounted) SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isFetching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isFetching) {
      return const Scaffold(backgroundColor: AppColors.background, body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text("Ofertas Finalizadas", style: AppTextStyles.title.copyWith(fontSize: 22)),
        iconTheme: const IconThemeData(color: AppColors.textLight),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              if (_ofertas.isEmpty)
                Expanded(child: Center(child: Text("Nenhuma oferta finalizada", style: AppTextStyles.subtitle)))
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: _ofertas.length,
                    itemBuilder: (context, index) {
                      final oferta = _ofertas[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/contratado/visualizar_oferta',
                              arguments: {'oferta_id': oferta.id, 'oferta_finalizada': oferta.finalizada},
                            );
                          },
                          child: OfertaCard(
                            titulo: oferta.titulo,
                            salario: oferta.salario,
                            dataInicio: oferta.dataInicio,
                            dataFim: oferta.dataFim,
                            status:
                                oferta.candidaturas != null && oferta.candidaturas!.isNotEmpty
                                    ? oferta.candidaturas![0].status
                                    : null,
                            isFinalizada: oferta.finalizada,
                            isContratante: false,
                            onAvaliar:
                                () => Navigator.pushNamed(
                                  context,
                                  '/avaliar_usuario',
                                  arguments: {
                                    'autor_id': oferta.candidaturas![0].id,
                                    'autor_tipo': 'contratado',
                                    'destinatario_id': oferta.contratante.id,
                                    'destinatario_tipo': 'contratante',
                                    'oferta_id': oferta.id,
                                  },
                                ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
