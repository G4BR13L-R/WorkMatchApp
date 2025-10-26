import 'package:flutter/material.dart';
import 'package:work_match_app/core/controllers/contratante/oferta_controller.dart';
import 'package:work_match_app/core/models/oferta_model.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/core/utils/snackbar_helper.dart';
import 'package:work_match_app/ui/widgets/oferta_card.dart';

class OfertaFinalizadaContratante extends StatefulWidget {
  const OfertaFinalizadaContratante({super.key});

  @override
  State<OfertaFinalizadaContratante> createState() => _OfertaFinalizadaContratanteState();
}

class _OfertaFinalizadaContratanteState extends State<OfertaFinalizadaContratante> {
  final OfertaController _contratanteOfertaController = OfertaController();

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
      final ofertas = await _contratanteOfertaController.index(status: true); // Ofertas finalizadas.

      if (mounted) setState(() => _ofertas = ofertas);
    } catch (e) {
      if (mounted) SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _isFetching = false);
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
                              '/contratante/visualizar_oferta',
                              arguments: {'oferta_id': oferta.id, 'oferta_finalizada': oferta.finalizada},
                            );
                          },
                          child: OfertaCard(
                            titulo: oferta.titulo,
                            salario: oferta.salario,
                            dataInicio: oferta.dataInicio,
                            dataFim: oferta.dataFim,
                            isFinalizada: oferta.finalizada,
                            isContratante: true,
                            onCandidatos:
                                () => Navigator.pushNamed(
                                  context,
                                  '/contratante/candidaturas',
                                  arguments: {'oferta_id': oferta.id, 'oferta_finalizada': oferta.finalizada},
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
