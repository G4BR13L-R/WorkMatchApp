import 'package:flutter/material.dart';
import 'package:work_match_app/core/controllers/contratante/candidatura_controller.dart';
import 'package:work_match_app/core/controllers/contratante/oferta_controller.dart';
import 'package:work_match_app/core/models/candidatura_model.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/core/utils/snackbar_helper.dart';
import 'package:work_match_app/ui/widgets/candidatura_card.dart';
import 'package:work_match_app/ui/widgets/custom_button.dart';

class CandidaturasContratante extends StatefulWidget {
  const CandidaturasContratante({super.key});

  @override
  State<CandidaturasContratante> createState() => _CandidaturasContratanteState();
}

class _CandidaturasContratanteState extends State<CandidaturasContratante> {
  final CandidaturaController _candidaturasController = CandidaturaController();
  final OfertaController _contratanteOfertaController = OfertaController();

  List<CandidaturaModel> _candidaturas = [];
  bool _isFetching = false;
  bool _isLoading = false;
  int? _ofertaId;
  late bool _ofertaFinalizada;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      _ofertaId = args?['oferta_id'] as int?;
      _ofertaFinalizada = args?['oferta_finalizada'] as bool? ?? false;

      if (_ofertaId != null) {
        _loadCandidaturas(_ofertaId!);
      }
    });
  }

  Future<void> _loadCandidaturas(int ofertaId) async {
    setState(() => _isFetching = true);

    try {
      final candidaturas = await _candidaturasController.index(ofertaId);

      if (mounted) setState(() => _candidaturas = candidaturas);
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
        title: Text("Candidaturas", style: AppTextStyles.title.copyWith(fontSize: 22)),
        iconTheme: const IconThemeData(color: AppColors.textLight),
      ),
      body: SafeArea(
        child: Column(
          children: [
            if (_candidaturas.isEmpty)
              Expanded(child: Center(child: Text("Nenhum candidato encontrado", style: AppTextStyles.subtitle)))
            else
              Expanded(
                child: ListView.builder(
                  itemCount: _candidaturas.length,
                  itemBuilder: (context, index) {
                    final candidatura = _candidaturas[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: GestureDetector(
                        onTap: () => {},
                        child: CandidaturaCard(
                          nome: candidatura.contratado.nome,
                          telefone: candidatura.contratado.telefone,
                          salario: candidatura.salario,
                          cidade: candidatura.contratado.endereco?.cidade?.descricao ?? '',
                          estado: candidatura.contratado.endereco?.cidade?.estado?.sigla ?? '',
                          status: candidatura.status,
                          oferta: candidatura.oferta,
                          onContratar: () => _isLoading ? null : _contratar(candidatura.id!),
                          onReprovar: () => _isLoading ? null : _reprovar(candidatura.id!),
                          onAvaliar:
                              () => Navigator.pushNamed(
                                context,
                                '/avaliar_usuario',
                                arguments: {
                                  'autor_id': candidatura.oferta.id,
                                  'autor_tipo': 'contratante',
                                  'destinatario_id': candidatura.contratado.id,
                                  'destinatario_tipo': 'contratado',
                                  'oferta_id': candidatura.oferta.id,
                                },
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ),

            if (!_ofertaFinalizada) ...[
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomButton(
                    text: "Finalizar Oferta",
                    backgroundColor: AppColors.primary,
                    textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
                    onPressed: _isLoading ? null : _finalizarOferta,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _contratar(int candidaturaId) async {
    setState(() => _isLoading = true);

    try {
      await _candidaturasController.changeStatus(candidaturaId, 2);

      if (!mounted) return;

      SnackbarHelper.showSuccess(context, 'Candidato contratado!');

      if (_ofertaId != null) _loadCandidaturas(_ofertaId!);
    } catch (e) {
      SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _reprovar(int candidaturaId) async {
    setState(() => _isLoading = true);

    try {
      await _candidaturasController.changeStatus(candidaturaId, 3);

      if (!mounted) return;

      SnackbarHelper.showSuccess(context, 'Candidato reprovado!');

      if (_ofertaId != null) _loadCandidaturas(_ofertaId!);
    } catch (e) {
      if (mounted) SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _finalizarOferta() async {
    setState(() => _isLoading = true);

    try {
      if (_ofertaId != null) await _contratanteOfertaController.finalizarOferta(_ofertaId!);

      if (!mounted) return;

      SnackbarHelper.showSuccess(context, 'Oferta finalizada com sucesso!');

      Navigator.pushNamedAndRemoveUntil(context, '/contratante/home', (Route<dynamic> route) => false);
    } catch (e) {
      if (mounted) SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
