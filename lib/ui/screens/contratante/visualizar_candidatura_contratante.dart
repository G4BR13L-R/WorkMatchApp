import 'package:flutter/material.dart';
import 'package:work_match_app/core/controllers/contratante/candidatura_controller.dart';
import 'package:work_match_app/core/models/avaliacao_model.dart';
import 'package:work_match_app/core/models/candidatura_model.dart';
import 'package:work_match_app/core/models/oferta_model.dart';
import 'package:work_match_app/core/models/status_model.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/core/utils/format_helper.dart';
import 'package:work_match_app/core/utils/snackbar_helper.dart';
import 'package:work_match_app/ui/widgets/custom_button.dart';

class VisualizarCandidaturaContratante extends StatefulWidget {
  const VisualizarCandidaturaContratante({super.key});

  @override
  State<VisualizarCandidaturaContratante> createState() => _VisualizarCandidaturaContratanteState();
}

class _VisualizarCandidaturaContratanteState extends State<VisualizarCandidaturaContratante> {
  String? _nome;
  String? _telefone;
  String? _dataNascimento;
  String? _cpf;
  String? _rg;
  String? _formacoes;
  String? _habilidades;
  String? _experiencias;
  String? _logradouro;
  String? _numero;
  String? _complemento;
  String? _bairro;
  String? _cidade;
  String? _estado;
  double? _salario;
  StatusModel? _status;
  OfertaModel? _oferta;
  List<AvaliacaoModel>? _avaliacoes;

  final CandidaturaController _candidaturaController = CandidaturaController();
  bool _isFetching = false;
  bool _isLoading = false;

  int? _candidaturaId;

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

      final args = ModalRoute.of(context)?.settings.arguments;
      _candidaturaId = args as int?;

      if (_candidaturaId != null) {
        _loadOferta(_candidaturaId!);
      }
    });
  }

  Future<void> _loadOferta(int id) async {
    setState(() => _isFetching = true);

    try {
      CandidaturaModel candidatura = await _candidaturaController.show(id);

      setState(() {
        _nome = candidatura.contratado.nome;
        _telefone = candidatura.contratado.telefone;
        _dataNascimento = FormatHelper.formatDateToBR(candidatura.contratado.dataNascimento);
        _cpf = candidatura.contratado.cpf;
        _rg = candidatura.contratado.rg;
        _formacoes = candidatura.contratado.formacoes;
        _habilidades = candidatura.contratado.habilidades;
        _experiencias = candidatura.contratado.experiencias;
        _logradouro = candidatura.contratado.endereco?.logradouro ?? '';
        _numero = candidatura.contratado.endereco?.numero ?? '';
        _complemento = candidatura.contratado.endereco?.complemento ?? '';
        _bairro = candidatura.contratado.endereco?.bairro ?? '';
        _cidade = candidatura.contratado.endereco?.cidade?.descricao ?? '';
        _estado = candidatura.contratado.endereco?.cidade?.estado?.descricao ?? '';
        _salario = candidatura.salario;
        _status = candidatura.status;
        _oferta = candidatura.oferta;
        _avaliacoes = candidatura.avaliacoes;
      });
    } catch (e) {
      if (mounted) SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
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
        title: Text("Candidatura", style: AppTextStyles.title.copyWith(fontSize: 22)),
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
                    if (_nome != null) Text(_nome!, style: _textStyleTitulo),

                    _divider(),
                    Text("Dados Pessoais", style: _textStyleTopico),
                    _infoRow("Data de Nascimento", _dataNascimento ?? ''),
                    _infoRow("CPF", _cpf ?? ''),
                    _infoRow("RG", _rg ?? ''),
                    _infoRow("Telefone", _telefone ?? ''),

                    _divider(),
                    Text("Endereço", style: _textStyleTopico),
                    _infoRow("Logradouro", _logradouro ?? ''),
                    _infoRow("Número", _numero ?? ''),
                    _infoRow("Complemento", _complemento ?? ''),
                    _infoRow("Bairro", _bairro ?? ''),
                    _infoRow("Cidade", _cidade ?? ''),
                    _infoRow("Estado", _estado ?? ''),

                    _divider(),
                    Text("Formação", style: _textStyleTopico),
                    _infoRow("", _formacoes ?? ''),

                    _divider(),
                    Text("Habilidades", style: _textStyleTopico),
                    _infoRow("", _habilidades ?? ''),

                    _divider(),
                    Text("Experiências", style: _textStyleTopico),
                    _infoRow("", _experiencias ?? ''),

                    _divider(),
                    Text("Pretensão Salarial", style: _textStyleTopico),
                    if (_salario != null) _infoRow("Salário desejado", "R\$ ${_salario!.toStringAsFixed(2)}"),

                    _divider(),
                    Text("Status da Candidatura", style: _textStyleTopico),
                    _infoRow("Status", _status?.descricao ?? ''),

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

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Row(
                children: [
                  if (_oferta != null && _oferta!.finalizada == false) ...[
                    if (_status?.id != 2) ...[
                      Expanded(
                        child: CustomButton(
                          text: 'Contratar',
                          backgroundColor: AppColors.primary,
                          textStyle: AppTextStyles.buttonOferta,
                          onPressed: () {
                            if (_candidaturaId != null && !_isLoading) {
                              _changeStatus(_candidaturaId!, 2);
                            }
                          },
                        ),
                      ),
                    ],

                    if (_status?.id == 1) ...[const SizedBox(width: 8)],

                    if (_status?.id != 3) ...[
                      Expanded(
                        child: CustomButton(
                          text: 'Reprovar',
                          backgroundColor: AppColors.warning,
                          textStyle: AppTextStyles.buttonOferta,
                          onPressed: () {
                            if (_candidaturaId != null && !_isLoading) {
                              _changeStatus(_candidaturaId!, 3);
                            }
                          },
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changeStatus(int candidaturaId, int statusId) async {
    setState(() => _isLoading = true);

    try {
      await _candidaturaController.changeStatus(candidaturaId, statusId);

      if (!mounted) return;

      SnackbarHelper.showSuccess(context, statusId == 2 ? 'Candidato contratado!' : 'Candidato reprovado!');

      Navigator.pop(context, true);
    } catch (e) {
      if (mounted) SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
