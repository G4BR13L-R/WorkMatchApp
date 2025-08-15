import 'package:flutter/material.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/ui/screens/auth/account_type.dart';
import 'package:work_match_app/ui/screens/contratante/home_contratante.dart';
import 'package:work_match_app/ui/screens/widgets/custom_button.dart';
import 'package:work_match_app/ui/screens/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  Icon(Icons.construction_rounded, size: 100, color: AppColors.primary),
                  const SizedBox(height: 16),

                  // Título
                  Text("WORK MATCH", style: AppTextStyles.title),
                  const SizedBox(height: 32),

                  // Campo Login
                  CustomTextField(hintText: "Login", icon: Icons.person, controller: _emailController),
                  const SizedBox(height: 16),

                  // Campo Senha
                  CustomTextField(
                    hintText: "Senha",
                    obscureText: true,
                    icon: Icons.lock,
                    controller: _passwordController,
                  ),
                  const SizedBox(height: 24),

                  // Botão Entrar
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: "Entrar",
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeContratante()));
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Cadastro
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const AccountType()));
                    },
                    child: const Text("Não tem cadastro? Cadastre-se", style: AppTextStyles.subtitle),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
