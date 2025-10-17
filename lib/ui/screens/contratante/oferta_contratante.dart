import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:work_match_app/core/controllers/contratante_oferta_controller.dart';
import 'package:work_match_app/core/models/cidade_model.dart';
import 'package:work_match_app/core/models/oferta_model.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/core/utils/snackbar_helper.dart';
import 'package:work_match_app/ui/widgets/cidade_autocomplete.dart';
import 'package:work_match_app/ui/widgets/custom_button.dart';
import 'package:work_match_app/ui/widgets/custom_text_field.dart';

class OfertaContratante extends StatefulWidget {
  const OfertaContratante({super.key});

  @override
  State<OfertaContratante> createState() => _OfertaContratanteState();
}

class _OfertaContratanteState extends State<OfertaContratante> {
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _salarioController = TextEditingController();
  final TextEditingController _dataInicioController = TextEditingController();
  final TextEditingController _dataFimController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();

  final ContratanteOfertaController _contratanteOfertaController = ContratanteOfertaController();
  bool _isLoading = false;
  bool _isFetching = false;
  CidadeModel? _cidadeSelecionada;

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

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _salarioController.dispose();
    _dataInicioController.dispose();
    _dataFimController.dispose();
    _logradouroController.dispose();
    _numeroController.dispose();
    _complementoController.dispose();
    _bairroController.dispose();
    _cidadeSelecionada = null;
    super.dispose();
  }

  Future<void> _loadOferta(int id) async {
    setState(() => _isFetching = true);

    try {
      OfertaModel oferta = await _contratanteOfertaController.show(id);

      String dataInicio = oferta.dataInicio.split('-').reversed.join('/');
      String dataFim = oferta.dataFim.split('-').reversed.join('/');

      _tituloController.text = oferta.titulo;
      _salarioController.text = oferta.salario.toStringAsFixed(2);
      _dataInicioController.text = dataInicio;
      _dataFimController.text = dataFim;
      _logradouroController.text = oferta.endereco.logradouro ?? '';
      _numeroController.text = oferta.endereco.numero ?? '';
      _complementoController.text = oferta.endereco.complemento ?? '';
      _bairroController.text = oferta.endereco.bairro ?? '';
      _cidadeSelecionada = oferta.endereco.cidade;
      _descricaoController.text = oferta.descricao;
    } catch (e) {
      if (!mounted) return;
      SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isFetching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final int? ofertaId = args as int?;

    final bool isEdicao = ofertaId != null;

    if (_isFetching) {
      return const Scaffold(backgroundColor: AppColors.background, body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text("Cadastro de Oferta", style: AppTextStyles.title.copyWith(fontSize: 22)),
        iconTheme: const IconThemeData(color: AppColors.textLight),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              CustomTextField(hintText: "Titulo", icon: Icons.text_fields, controller: _tituloController),
              const SizedBox(height: 16),

              CustomTextField(
                hintText: "Salario",
                icon: Icons.attach_money,
                controller: _salarioController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: "Data de Inicio",
                      icon: Icons.date_range,
                      controller: _dataInicioController,
                      keyboardType: TextInputType.datetime,
                      inputFormatters: [
                        MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')}),
                      ],
                    ),
                  ),

                  SizedBox(width: 5),

                  Expanded(
                    child: CustomTextField(
                      hintText: "Data de Fim",
                      icon: Icons.date_range,
                      controller: _dataFimController,
                      keyboardType: TextInputType.datetime,
                      inputFormatters: [
                        MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')}),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              CustomTextField(hintText: "Logradouro", icon: Icons.location_on, controller: _logradouroController),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomTextField(
                      hintText: 'Número',
                      icon: Icons.numbers,
                      controller: _numeroController,
                      keyboardType: TextInputType.number,
                    ),
                  ),

                  SizedBox(width: 5),

                  Expanded(
                    flex: 4,
                    child: CustomTextField(hintText: "Bairro", icon: Icons.home_work, controller: _bairroController),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              CustomTextField(
                hintText: "Complemento",
                icon: Icons.add_location_alt,
                controller: _complementoController,
              ),
              const SizedBox(height: 16),

              CidadeAutoComplete(
                initialValue: _cidadeSelecionada,
                onSelected: (cidade) {
                  setState(() => _cidadeSelecionada = cidade);
                },
              ),
              const SizedBox(height: 40),

              CustomTextField(
                hintText: "Descricao",
                icon: Icons.text_fields,
                controller: _descricaoController,
                keyboardType: TextInputType.multiline,
                minLine: 8,
                maxLine: null,
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: isEdicao ? "Editar Oferta" : "Cadastrar Oferta",
                  onPressed: () => _isLoading ? null : _gravarOfertaContratante(ofertaId),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _gravarOfertaContratante(int? id) async {
    setState(() => _isLoading = true);

    try {
      final salario = double.tryParse(_salarioController.text);
      final cidadeId = _cidadeSelecionada?.id;

      if (salario == null) {
        String error = "O campo salário deve ser um número válido";

        if (_salarioController.text.isEmpty) {
          error = "O campo salário é obrigatório";
        }

        throw Exception(error);
      }

      if (cidadeId == null) throw Exception("O campo cidade é obrigatório");

      if (id != null) {
        await _contratanteOfertaController.update(
          id,
          _tituloController.text,
          _descricaoController.text,
          salario,
          _dataInicioController.text,
          _dataFimController.text,
          _logradouroController.text,
          _numeroController.text,
          _complementoController.text,
          _bairroController.text,
          cidadeId,
        );
      } else {
        await _contratanteOfertaController.register(
          _tituloController.text,
          _descricaoController.text,
          salario,
          _dataInicioController.text,
          _dataFimController.text,
          _logradouroController.text,
          _numeroController.text,
          _complementoController.text,
          _bairroController.text,
          cidadeId,
        );
      }

      if (!mounted) return;

      SnackbarHelper.showSuccess(context, "Oferta cadastrada com sucesso!");
      Navigator.pushNamedAndRemoveUntil(context, '/contratante/home', (Route<dynamic> route) => false);
    } catch (e) {
      if (!mounted) return;
      SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
