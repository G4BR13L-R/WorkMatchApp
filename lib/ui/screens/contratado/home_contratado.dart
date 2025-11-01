import 'package:flutter/material.dart';
import 'package:work_match_app/core/controllers/contratado/oferta_controller.dart';
import 'package:work_match_app/core/models/oferta_model.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/core/utils/snackbar_helper.dart';
import 'package:work_match_app/ui/widgets/custom_button.dart';
import 'package:work_match_app/ui/widgets/oferta_card.dart';

class HomeContratado extends StatefulWidget {
  const HomeContratado({super.key});

  @override
  State<HomeContratado> createState() => _HomeContratadoState();
}

class _HomeContratadoState extends State<HomeContratado> {
  final OfertaController _ofertaController = OfertaController();

  List<OfertaModel> _ofertas = [];
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    _loadOfertas();
  }

  Future<void> _loadOfertas({int? cidadeId}) async {
    setState(() => _isFetching = true);

    try {
      final ofertas = await _ofertaController.index(status: false, cidadeId: cidadeId); // Ofertas não finalizadas.

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Ofertas Finalizadas',
                      backgroundColor: AppColors.primary,
                      textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                      onPressed: () {
                        Navigator.pushNamed(context, '/contratado/oferta_finalizada').then((_) => _loadOfertas());
                      },
                    ),
                  ),

                  SizedBox(width: 30),

                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/contratado/profile').then((_) => _loadOfertas()),
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              if (_ofertas.isEmpty)
                Expanded(child: Center(child: Text("Nenhuma oferta cadastrada", style: AppTextStyles.subtitle)))
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
                              arguments: {'oferta_id': oferta.id},
                            ).then((_) => _loadOfertas());
                          },
                          child: OfertaCard(
                            titulo: oferta.titulo,
                            salario: oferta.salario,
                            dataInicio: oferta.dataInicio,
                            dataFim: oferta.dataFim,
                            isFinalizada: oferta.finalizada,
                            isContratante: false,
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
