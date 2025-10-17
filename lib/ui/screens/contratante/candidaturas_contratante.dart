import 'package:flutter/material.dart';
import 'package:work_match_app/core/controllers/contratante_oferta_controller.dart';
import 'package:work_match_app/core/models/oferta_model.dart';
import 'package:work_match_app/core/utils/format_helper.dart';
import 'package:work_match_app/core/utils/snackbar_helper.dart';

class CandidaturasContratante extends StatefulWidget {
  const CandidaturasContratante({super.key});

  @override
  State<CandidaturasContratante> createState() => _CandidaturasContratanteState();
}

class _CandidaturasContratanteState extends State<CandidaturasContratante> {
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

  final ContratanteOfertaController _contratanteOfertaController = ContratanteOfertaController();
  bool _isLoading = false;
  bool _isFetching = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
