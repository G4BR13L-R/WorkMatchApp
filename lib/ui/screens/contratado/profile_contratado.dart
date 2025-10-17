import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/core/utils/format_helper.dart';
import 'package:work_match_app/core/utils/snackbar_helper.dart';
import 'package:work_match_app/core/models/cidade_model.dart';
import 'package:work_match_app/core/models/contratado_model.dart';
import 'package:work_match_app/core/controllers/auth_controller.dart';
import 'package:work_match_app/core/controllers/contratado_profile_controller.dart';
import 'package:work_match_app/ui/widgets/cidade_autocomplete.dart';
import 'package:work_match_app/ui/widgets/custom_button.dart';
import 'package:work_match_app/ui/widgets/custom_text_field.dart';

class ProfileContratado extends StatefulWidget {
  const ProfileContratado({super.key});

  @override
  State<ProfileContratado> createState() => _ProfileContratadoState();
}

class _ProfileContratadoState extends State<ProfileContratado> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dataNascimentoController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  CidadeModel? _cidadeSelecionada;

  final _telefoneFormatter = MaskTextInputFormatter(mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')});
  final _dataNascimentoFormatter = MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')});
  final _cpfFormatter = MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});

  final AuthController _authController = AuthController();
  final ContratadoProfileController _contratadoProfileController = ContratadoProfileController();

  bool _isLoading = false;
  bool _isFetching = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    _emailController.dispose();
    _dataNascimentoController.dispose();
    _cpfController.dispose();
    _rgController.dispose();
    _logradouroController.dispose();
    _numeroController.dispose();
    _complementoController.dispose();
    _bairroController.dispose();
    _cidadeSelecionada = null;
    super.dispose();
  }

  Future<void> _loadProfile() async {
    try {
      ContratadoModel contratado = await _contratadoProfileController.show();

      String dataNascimento = FormatHelper.formatDateToBR(contratado.dataNascimento);

      _nomeController.text = contratado.nome;
      _telefoneController.text = _telefoneFormatter.maskText(contratado.telefone);
      _emailController.text = contratado.email;
      _dataNascimentoController.text = _dataNascimentoFormatter.maskText(dataNascimento);
      _cpfController.text = _cpfFormatter.maskText(contratado.cpf);
      _rgController.text = contratado.rg ?? '';
      _logradouroController.text = contratado.endereco?.logradouro ?? '';
      _numeroController.text = contratado.endereco?.numero ?? '';
      _complementoController.text = contratado.endereco?.complemento ?? '';
      _bairroController.text = contratado.endereco?.bairro ?? '';
      _cidadeSelecionada = contratado.endereco?.cidade;
    } catch (e) {
      if (!mounted) return;
      SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isFetching = false);
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
        title: Text("Editar Perfil", style: AppTextStyles.title.copyWith(fontSize: 22)),
        iconTheme: const IconThemeData(color: AppColors.textLight),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: "Segurança da Conta",
                  backgroundColor: AppColors.accent,
                  onPressed: () => Navigator.pushNamed(context, '/contratado/security_account'),
                ),
              ),
              const SizedBox(height: 24),

              CustomTextField(hintText: "Nome", icon: Icons.person, controller: _nomeController),
              const SizedBox(height: 16),

              CustomTextField(
                hintText: "Telefone",
                icon: Icons.phone,
                controller: _telefoneController,
                inputFormatters: [_telefoneFormatter],
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),

              CustomTextField(hintText: "Email", icon: Icons.email, controller: _emailController),
              const SizedBox(height: 16),

              CustomTextField(
                hintText: "Data de Nascimento",
                icon: Icons.business,
                controller: _dataNascimentoController,
                inputFormatters: [_dataNascimentoFormatter],
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                hintText: "CPF",
                icon: Icons.account_balance,
                controller: _cpfController,
                inputFormatters: [_cpfFormatter],
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                hintText: "RG",
                icon: Icons.storefront,
                controller: _rgController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              CustomTextField(hintText: "Logradouro", icon: Icons.location_on, controller: _logradouroController),
              const SizedBox(height: 16),

              CustomTextField(
                hintText: "Número",
                icon: Icons.confirmation_number,
                controller: _numeroController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                hintText: "Complemento",
                icon: Icons.add_location_alt,
                controller: _complementoController,
              ),
              const SizedBox(height: 16),

              CustomTextField(hintText: "Bairro", icon: Icons.home_work, controller: _bairroController),
              const SizedBox(height: 16),

              CidadeAutoComplete(
                initialValue: _cidadeSelecionada,
                onSelected: (cidade) {
                  setState(() => _cidadeSelecionada = cidade);
                },
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: CustomButton(text: "Salvar Alterações", onPressed: () => _isLoading ? null : _updateProfile()),
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: "Sair",
                  backgroundColor: AppColors.warning,
                  onPressed: () => _isLoading ? null : _logout(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateProfile() async {
    setState(() => _isLoading = true);

    try {
      await _contratadoProfileController.update(
        _nomeController.text.trim(),
        _telefoneController.text.trim(),
        _emailController.text.trim(),
        _dataNascimentoController.text.trim(),
        _cpfController.text.trim(),
        _rgController.text.trim(),
        _logradouroController.text.trim(),
        _numeroController.text.trim(),
        _complementoController.text.trim(),
        _bairroController.text.trim(),
        _cidadeSelecionada?.id,
      );

      if (!mounted) return;

      SnackbarHelper.showSuccess(context, "Perfil atualizado com sucesso!");
    } catch (e) {
      if (!mounted) return;
      SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _logout() async {
    setState(() => _isLoading = true);

    bool logout = await _authController.logout();

    if (!mounted) return;

    if (!logout) {
      SnackbarHelper.showError(context, "Falha ao realizar logout!");
      return;
    }

    SnackbarHelper.showSuccess(context, "Logout realizado com sucesso!");
    Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);

    setState(() => _isLoading = false);
  }
}
