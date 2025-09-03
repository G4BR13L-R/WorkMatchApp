import 'package:flutter/material.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/core/utils/snackbar_helper.dart';
import 'package:work_match_app/data/models/cidade_model.dart';
import 'package:work_match_app/data/models/contratante_model.dart';
import 'package:work_match_app/ui/controllers/auth_controller.dart';
import 'package:work_match_app/ui/controllers/contratante_profile_controller.dart';
import 'package:work_match_app/ui/screens/widgets/cidade_autocomplete.dart';
import 'package:work_match_app/ui/screens/widgets/custom_button.dart';
import 'package:work_match_app/ui/screens/widgets/custom_text_field.dart';

class ProfileContratante extends StatefulWidget {
  const ProfileContratante({super.key});

  @override
  State<ProfileContratante> createState() => _ProfileContratanteState();
}

class _ProfileContratanteState extends State<ProfileContratante> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _razaoSocialController = TextEditingController();
  final TextEditingController _nomeFantasiaController = TextEditingController();
  final TextEditingController _logradouroController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _complementoController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  CidadeModel? _cidadeSelecionada;

  final AuthController authController = AuthController();
  final ContratanteProfileController contratanteProfileController = ContratanteProfileController();

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
    _cnpjController.dispose();
    _razaoSocialController.dispose();
    _nomeFantasiaController.dispose();
    _logradouroController.dispose();
    _numeroController.dispose();
    _complementoController.dispose();
    _bairroController.dispose();
    _cidadeSelecionada = null;
    super.dispose();
  }

  Future<void> _loadProfile() async {
    try {
      ContratanteModel contratanteModel = await contratanteProfileController.show();

      _nomeController.text = contratanteModel.nome;
      _telefoneController.text = contratanteModel.telefone;
      _emailController.text = contratanteModel.email;
      _cnpjController.text = contratanteModel.cnpj;
      _razaoSocialController.text = contratanteModel.razaoSocial;
      _nomeFantasiaController.text = contratanteModel.nomeFantasia;
      _logradouroController.text = contratanteModel.endereco?.logradouro ?? '';
      _numeroController.text = contratanteModel.endereco?.numero ?? '';
      _complementoController.text = contratanteModel.endereco?.complemento ?? '';
      _bairroController.text = contratanteModel.endereco?.bairro ?? '';
      _cidadeSelecionada = contratanteModel.endereco?.cidade;
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
                  text: "Alterar Senha",
                  onPressed: () => Navigator.pushNamed(context, '/contratante/change_password'),
                ),
              ),
              const SizedBox(height: 24),

              CustomTextField(hintText: "Nome", icon: Icons.person, controller: _nomeController),
              const SizedBox(height: 16),

              CustomTextField(hintText: "Telefone", icon: Icons.phone, controller: _telefoneController),
              const SizedBox(height: 16),

              CustomTextField(hintText: "Email", icon: Icons.email, controller: _emailController),
              const SizedBox(height: 16),

              CustomTextField(hintText: "CNPJ", icon: Icons.business, controller: _cnpjController),
              const SizedBox(height: 16),

              CustomTextField(
                hintText: "Razão Social",
                icon: Icons.account_balance,
                controller: _razaoSocialController,
              ),
              const SizedBox(height: 16),

              CustomTextField(hintText: "Nome Fantasia", icon: Icons.storefront, controller: _nomeFantasiaController),
              const SizedBox(height: 16),

              CustomTextField(hintText: "Logradouro", icon: Icons.location_on, controller: _logradouroController),
              const SizedBox(height: 16),

              CustomTextField(hintText: "Número", icon: Icons.confirmation_number, controller: _numeroController),
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
      bool status = await contratanteProfileController.update(
        _nomeController.text.trim(),
        _telefoneController.text.trim(),
        _emailController.text.trim(),
        _cnpjController.text.trim(),
        _razaoSocialController.text.trim(),
        _nomeFantasiaController.text.trim(),
        _logradouroController.text.trim(),
        _numeroController.text.trim(),
        _complementoController.text.trim(),
        _bairroController.text.trim(),
        _cidadeSelecionada?.id,
      );

      if (!mounted) return;

      if (status) {
        SnackbarHelper.showSuccess(context, "Perfil atualizado com sucesso!");
      } else {
        SnackbarHelper.showError(context, "Falha ao atualizar perfil!");
      }
    } catch (e) {
      if (!mounted) return;
      SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _logout() async {
    setState(() => _isLoading = true);

    bool logout = await authController.logout();

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
