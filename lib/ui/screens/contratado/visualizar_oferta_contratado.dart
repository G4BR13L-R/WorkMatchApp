import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:work_match_app/core/controllers/contratado/oferta_controller.dart';
import 'package:work_match_app/core/models/avaliacao_model.dart';
import 'package:work_match_app/core/models/candidatura_model.dart';
import 'package:work_match_app/core/models/contratante_model.dart';
import 'package:work_match_app/core/models/oferta_model.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/core/utils/format_helper.dart';
import 'package:work_match_app/core/utils/snackbar_helper.dart';
import 'package:work_match_app/ui/widgets/custom_button.dart';
import 'package:work_match_app/ui/widgets/custom_input_dialog.dart';

class VisualizarOfertaContratado extends StatefulWidget {
  const VisualizarOfertaContratado({super.key});

  @override
  State<VisualizarOfertaContratado> createState() => _VisualizarOfertaContratadoState();
}

class _VisualizarOfertaContratadoState extends State<VisualizarOfertaContratado> {
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
  ContratanteModel? _contratante;
  List<CandidaturaModel>? _candidaturas;
  List<AvaliacaoModel>? _avaliacoes;

  final _cnpjFormatter = MaskTextInputFormatter(mask: '##.###.###/####-##', filter: {"#": RegExp(r'[0-9]')});
  final _telefoneFormatter = MaskTextInputFormatter(mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});

  final OfertaController _ofertaController = OfertaController();
  bool _isFetching = false;
  bool _isLoading = false;

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
        _contratante = oferta.contratante;
        _candidaturas = oferta.candidaturas;
        _avaliacoes = oferta.avaliacoes;
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
            "Por: ${avaliacao.autor_nome}",
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
                    if (_candidaturas != null && _candidaturas!.isNotEmpty) ...[
                      Text("${_titulo?.trim() ?? ''} (${_candidaturas![0].status.descricao})", style: _textStyleTitulo),
                    ] else ...[
                      Text(_titulo?.trim() ?? '', style: _textStyleTitulo),
                    ],

                    const SizedBox(height: 16),

                    // Salário e período
                    if (_salario != null) _infoRow("Salário", "R\$ ${_salario!.toStringAsFixed(2)}"),
                    if (_dataInicio != null || _dataFim != null)
                      _infoRow("Período", "${_dataInicio ?? '-'} até ${_dataFim ?? '-'}"),

                    if (_candidaturas != null && _candidaturas!.isNotEmpty && _candidaturas![0].status.id == 2) ...[
                      _infoRow('Status', 'Aguarde o contato do contratante!'),
                    ],

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

                    // Contratante
                    _divider(),
                    Text("Contratante", style: _textStyleTopico),
                    const SizedBox(height: 8),
                    _infoRow('Nome', _contratante?.nomeFantasia ?? ''),
                    _infoRow("CNPJ", _cnpjFormatter.maskText(_contratante?.cnpj ?? '')),
                    _infoRow('Telefone', _telefoneFormatter.maskText(_contratante?.telefone ?? '')),
                    _infoRow("Email", _contratante?.email ?? ''),

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

            if (_ofertaFinalizada &&
                _candidaturas != null &&
                _candidaturas!.isNotEmpty &&
                _candidaturas![0].status.id == 2) ...[
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: CustomButton(
                    text: "Avaliar",
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/avaliar_usuario',
                        arguments: {
                          'autor_id': _candidaturas![0].contratado.id,
                          'autor_tipo': 'contratado',
                          'destinatario_id': _contratante!.id,
                          'destinatario_tipo': 'contratante',
                          'oferta_id': _ofertaId,
                        },
                      );
                    },
                  ),
                ),
              ),
            ],

            if (!_ofertaFinalizada) ...[
              if (_candidaturas == null || _candidaturas!.isEmpty) ...[
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                    child: CustomButton(
                      text: "Candidatar-se",
                      onPressed: () async {
                        if (_isLoading || _ofertaId == null) return;

                        String? input = await customInputDialog(
                          context,
                          title: 'Candidatura',
                          label: 'Informe o salário',
                        );

                        double? salario;

                        if (input != null && input.isNotEmpty) {
                          salario = double.tryParse(input);

                          if (salario == null) {
                            if (context.mounted) SnackbarHelper.showError(context, 'Salário inválido');
                            return;
                          }
                        }

                        _candidatar(_ofertaId!, salario);
                      },
                    ),
                  ),
                ),
              ] else if (_candidaturas![0].status.id == 1) ...[
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                    child: CustomButton(
                      text: "Retirar Candidatura",
                      backgroundColor: AppColors.warning,
                      onPressed: () => _isLoading ? null : _retirarCandidatura(_candidaturas![0].id!),
                    ),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _candidatar(int ofertaId, double? salario) async {
    setState(() => _isLoading = true);

    try {
      CandidaturaModel candidatura = await _ofertaController.store(ofertaId, salario);

      if (_candidaturas == null || _candidaturas!.isEmpty) {
        setState(() => _candidaturas = [candidatura]);
      }
    } catch (e) {
      if (mounted) SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _retirarCandidatura(int candidaturaId) async {
    setState(() => _isLoading = true);

    try {
      await _ofertaController.destroy(candidaturaId);

      _candidaturas?.removeWhere((candidatura) => candidatura.id == candidaturaId);
    } catch (e) {
      if (mounted) SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
