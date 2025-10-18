import 'package:flutter/material.dart';
import 'package:work_match_app/core/controllers/contratante_oferta_controller.dart';
import 'package:work_match_app/core/models/oferta_model.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/core/utils/snackbar_helper.dart';
import 'package:work_match_app/ui/widgets/custom_button.dart';
import 'package:work_match_app/ui/widgets/custom_dialog.dart';
import 'package:work_match_app/ui/widgets/oferta_card.dart';

class HomeContratante extends StatefulWidget {
  const HomeContratante({super.key});

  @override
  State<HomeContratante> createState() => _HomeContratanteState();
}

class _HomeContratanteState extends State<HomeContratante> {
  final ContratanteOfertaController _contratanteOfertaController = ContratanteOfertaController();

  List<OfertaModel> _ofertas = [];
  bool _isLoading = false;
  bool _isFetching = false;

  @override
  void initState() {
    super.initState();
    _loadOfertas();
  }

  Future<void> _loadOfertas() async {
    setState(() => _isFetching = true);

    try {
      final ofertas = await _contratanteOfertaController.index();

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => Navigator.pushNamed(context, '/contratante/oferta'),
        child: const Icon(Icons.add, color: Colors.black),
      ),
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
                      onPressed: () => {},
                    ),
                  ),

                  SizedBox(width: 30),

                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/contratante/profile'),
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
                          onTap: () => Navigator.pushNamed(context, '/contratante/candidaturas', arguments: oferta.id),
                          child: OfertaCard(
                            titulo: oferta.titulo,
                            salario: oferta.salario,
                            dataInicio: oferta.dataInicio,
                            dataFim: oferta.dataFim,
                            onEditar: () => Navigator.pushNamed(context, '/contratante/oferta', arguments: oferta.id),
                            onExcluir: () {
                              if (_isLoading || oferta.id == null) return;
                              _excluirOferta(oferta.id!);
                            },
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

  Future<void> _excluirOferta(int id) async {
    setState(() => _isLoading = true);

    try {
      final status = await CustomDialog(
        context,
        'Confirmar Exclusão',
        'Deseja realmente excluir esta oferta?',
        type: 'delete',
      );

      if (!mounted || !status) return;

      await _contratanteOfertaController.destroy(id);

      if (!mounted) return;

      SnackbarHelper.showSuccess(context, "Oferta excluída com sucesso!");
      _loadOfertas();
    } catch (e) {
      if (mounted) SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}
