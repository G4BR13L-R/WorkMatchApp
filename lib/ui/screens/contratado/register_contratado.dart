import 'package:flutter/material.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/core/utils/snackbar_helper.dart';
import 'package:work_match_app/ui/controllers/contratado_profile_controller.dart';
import 'package:work_match_app/ui/screens/widgets/custom_button.dart';
import 'package:work_match_app/ui/screens/widgets/custom_text_field.dart';

class RegisterContratado extends StatefulWidget {
  const RegisterContratado({super.key});

  @override
  State<RegisterContratado> createState() => _RegisterContratadoState();
}

class _RegisterContratadoState extends State<RegisterContratado> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _dataNascimentoController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _rgController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final ContratadoProfileController _contratadoProfileController = ContratadoProfileController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    _dataNascimentoController.dispose();
    _cpfController.dispose();
    _rgController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Contratante", style: AppTextStyles.title.copyWith(fontSize: 26)),
                const SizedBox(height: 24),

                CustomTextField(hintText: "Nome", icon: Icons.person, controller: _nomeController),
                const SizedBox(height: 16),

                CustomTextField(
                  hintText: "Telefone (somente números)",
                  icon: Icons.phone,
                  controller: _telefoneController,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  hintText: "Data de Nascimento",
                  icon: Icons.business,
                  controller: _dataNascimentoController,
                ),
                const SizedBox(height: 16),

                CustomTextField(hintText: "CPF", icon: Icons.account_balance, controller: _cpfController),
                const SizedBox(height: 16),

                CustomTextField(hintText: "RG", icon: Icons.storefront, controller: _rgController),
                const SizedBox(height: 16),

                CustomTextField(hintText: "Email", icon: Icons.email, controller: _emailController),
                const SizedBox(height: 16),

                CustomTextField(
                  hintText: "Senha",
                  obscureText: true,
                  icon: Icons.lock,
                  controller: _passwordController,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  hintText: "Confirmar Senha",
                  obscureText: true,
                  icon: Icons.lock_outline,
                  controller: _confirmPasswordController,
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: CustomButton(text: "Cadastrar", onPressed: () => _isLoading ? null : _registerContratante()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _registerContratante() async {
    setState(() => _isLoading = true);

    try {
      await _contratadoProfileController.register(
        _nomeController.text.trim(),
        _telefoneController.text.trim(),
        _dataNascimentoController.text.trim(),
        _cpfController.text.trim(),
        _rgController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _confirmPasswordController.text.trim(),
      );

      if (!mounted) return;

      SnackbarHelper.showSuccess(context, "Cadastro realizado com sucesso!");
      Navigator.pushReplacementNamed(context, '/contratado/home');
    } catch (e) {
      if (!mounted) return;
      SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
