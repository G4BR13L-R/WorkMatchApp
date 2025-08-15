import 'package:flutter/material.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/ui/screens/widgets/custom_button.dart';
import 'package:work_match_app/ui/screens/widgets/custom_text_field.dart';

class ContratanteRegister extends StatefulWidget {
  const ContratanteRegister({super.key});

  @override
  State<ContratanteRegister> createState() => _ContratanteRegisterState();
}

class _ContratanteRegisterState extends State<ContratanteRegister> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _razaoSocialController = TextEditingController();
  final TextEditingController _nomeFantasiaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    _cnpjController.dispose();
    _razaoSocialController.dispose();
    _nomeFantasiaController.dispose();
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
                  child: CustomButton(
                    text: "Cadastrar",
                    onPressed: () {
                      // ação de cadastro
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
