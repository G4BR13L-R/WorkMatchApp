import 'package:flutter/material.dart';
import 'package:work_match_app/core/controllers/contratante/oferta_controller.dart';
import 'package:work_match_app/core/models/oferta_model.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/utils/format_helper.dart';
import 'package:work_match_app/core/utils/snackbar_helper.dart';
import 'package:work_match_app/ui/widgets/custom_button.dart';

class VisualizarOfertaContratante extends StatefulWidget {
  const VisualizarOfertaContratante({super.key});

  @override
  State<VisualizarOfertaContratante> createState() => _VisualizarOfertaContratanteState();
}

class _VisualizarOfertaContratanteState extends State<VisualizarOfertaContratante> {
  String? _titulo;
  double? _salario;
  String? _dataInicio;
  String? _dataFim;
  String? _logradouro;
  String? _numero;
  String? _complemento;
  String? _bairro;
  String? _cidade;
  String? _estado;
  String? _descricao;

  final OfertaController _contratanteOfertaController = OfertaController();
  bool _isFetching = false;

  final _textStyleTitulo = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
    letterSpacing: 0.5,
  );

  final _textStyleTopico = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary);
  final _textStyleLabel = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textLight);
  final _textStyleValor = TextStyle(fontSize: 16, color: AppColors.textLight, height: 1.5);

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      final args = ModalRoute.of(context)?.settings.arguments;

      if (args != null && args is int) {
        _loadOferta(args);
      }
    });
  }

  Future<void> _loadOferta(int id) async {
    setState(() => _isFetching = true);

    try {
      OfertaModel oferta = await _contratanteOfertaController.show(id);

      setState(() {
        _titulo = oferta.titulo;
        _salario = oferta.salario;
        _dataInicio = FormatHelper.formatDateToBR(oferta.dataInicio);
        _dataFim = FormatHelper.formatDateToBR(oferta.dataFim);
        _logradouro = oferta.endereco.logradouro ?? '';
        _numero = oferta.endereco.numero ?? '';
        _complemento = oferta.endereco.complemento ?? '';
        _bairro = oferta.endereco.bairro ?? '';
        _cidade = oferta.endereco.cidade?.descricao ?? '';
        _estado = oferta.endereco.cidade?.estado?.descricao ?? '';
        _descricao = oferta.descricao;
      });
    } catch (e) {
      if (!mounted) return;
      SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isFetching = false);
    }
  }

  Widget _infoRow(String label, String text) {
    final value = text.trim();

    if (value.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text("$label: ", style: _textStyleLabel), Expanded(child: Text(value, style: _textStyleValor))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final int? ofertaId = args as int?;

    if (_isFetching) {
      return const Scaffold(backgroundColor: AppColors.background, body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título da vaga
                    Text(_titulo?.trim() ?? '', style: _textStyleTitulo),
                    const SizedBox(height: 16),

                    // Salário e período
                    if (_salario != null) _infoRow("Salário", "R\$ ${_salario!.toStringAsFixed(2)}"),
                    if (_dataInicio != null || _dataFim != null)
                      _infoRow("Período", "${_dataInicio ?? '-'} até ${_dataFim ?? '-'}"),

                    const Divider(height: 32, color: Colors.white24, thickness: 1),

                    // Localização
                    Text("Localização", style: _textStyleTopico),
                    const SizedBox(height: 8),
                    _infoRow("Logradouro", _logradouro ?? ''),
                    _infoRow("Número", _numero ?? ''),
                    _infoRow("Complemento", _complemento ?? ''),
                    _infoRow("Bairro", _bairro ?? ''),
                    _infoRow("Cidade", _cidade ?? ''),
                    _infoRow("Estado", _estado ?? ''),

                    const Divider(height: 32, color: Colors.white24, thickness: 1),

                    // Descrição
                    Text("Descrição da Vaga", style: _textStyleTopico),
                    const SizedBox(height: 8),
                    Text(_descricao ?? '-', style: _textStyleValor, textAlign: TextAlign.justify),
                  ],
                ),
              ),
            ),

            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomButton(
                  text: "Candidatos",
                  onPressed: () => Navigator.pushNamed(context, '/contratante/candidaturas', arguments: ofertaId),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
