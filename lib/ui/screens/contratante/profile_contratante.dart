import 'package:flutter/material.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/ui/screens/contratante/change_password.dart';
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ChangePassword()));
                  },
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

              // const CustomTextField(hintText: "Cidade ID", icon: Icons.location_city),
              // const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: "Salvar Alterações",
                  onPressed: () {
                    // Ação salvar perfil
                  },
                ),
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: "Sair",
                  backgroundColor: AppColors.warning,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const ChangePassword()));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
