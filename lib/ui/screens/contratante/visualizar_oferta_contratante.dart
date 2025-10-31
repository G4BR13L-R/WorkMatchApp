import 'package:flutter/material.dart';
import 'package:work_match_app/core/controllers/contratante/oferta_controller.dart';
import 'package:work_match_app/core/models/avaliacao_model.dart';
import 'package:work_match_app/core/models/oferta_model.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
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
  List<AvaliacaoModel>? _avaliacoes;

  final OfertaController _ofertaController = OfertaController();
  bool _isFetching = false;

  int? _ofertaId;
  bool _ofertaFinalizada = false;

  final _textStyleTitulo = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
    letterSpacing: 0.5,
  );

  final _textStyleTopico = TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary);
  final _textStyleLabel = TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textLight);
  final _textStyleValor = TextStyle(fontSize: 16, color: AppColors.textLight);

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      setState(() {
        _ofertaId = args?['oferta_id'] as int?;
        _ofertaFinalizada = args?['oferta_finalizada'] as bool? ?? false;
      });

      if (_ofertaId != null) {
        _loadOferta(_ofertaId!);
      }
    });
  }

  Future<void> _loadOferta(int id) async {
    setState(() => _isFetching = true);

    try {
      OfertaModel oferta = await _ofertaController.show(id);

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
        _avaliacoes = oferta.avaliacoes;
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (label.isNotEmpty) Text("$label: ", style: _textStyleLabel),
          Expanded(child: Text(value, style: _textStyleValor)),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(height: 32, color: Colors.white24, thickness: 1);

  Widget _avaliacaoItem(AvaliacaoModel avaliacao) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(5, (index) {
              final i = index + 1;
              return Icon(i <= (avaliacao.nota) ? Icons.star : Icons.star_border, color: Colors.amber, size: 22);
            }),
          ),
          const SizedBox(height: 6),

          if (avaliacao.comentario != null && avaliacao.comentario!.trim().isNotEmpty)
            Text(avaliacao.comentario!, style: _textStyleValor),
          const SizedBox(height: 6),
          Text(
            "Por: ${avaliacao.oferta.contratante.nome}",
            style: _textStyleValor.copyWith(fontStyle: FontStyle.italic, fontSize: 14),
          ),
        ],
      ),
    );
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
        title: Text("Oferta", style: AppTextStyles.title.copyWith(fontSize: 22)),
        iconTheme: const IconThemeData(color: AppColors.textLight),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 4, bottom: 16, left: 16, right: 16),
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

                    _divider(),

                    // Localização
                    Text("Localização", style: _textStyleTopico),
                    const SizedBox(height: 8),
                    _infoRow("Logradouro", _logradouro ?? ''),
                    _infoRow("Número", _numero ?? ''),
                    _infoRow("Complemento", _complemento ?? ''),
                    _infoRow("Bairro", _bairro ?? ''),
                    _infoRow("Cidade", _cidade ?? ''),
                    _infoRow("Estado", _estado ?? ''),

                    _divider(),

                    // Descrição
                    Text("Descrição da Vaga", style: _textStyleTopico),
                    const SizedBox(height: 8),
                    Text(_descricao ?? '-', style: _textStyleValor, textAlign: TextAlign.justify),

                    _divider(),
                    Text("Avaliações", style: _textStyleTopico),

                    if (_avaliacoes != null && _avaliacoes!.isNotEmpty) ...[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _avaliacoes!.map((avaliacao) => _avaliacaoItem(avaliacao)).toList(),
                      ),
                    ] else ...[
                      _infoRow("", "Ainda não há avaliações."),
                    ],
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
                  onPressed:
                      () => Navigator.pushNamed(
                        context,
                        '/contratante/candidaturas',
                        arguments: {'oferta_id': _ofertaId, 'oferta_finalizada': _ofertaFinalizada},
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
