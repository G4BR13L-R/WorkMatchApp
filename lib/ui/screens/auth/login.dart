import 'package:flutter/material.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/core/utils/snackbar_helper.dart';
import 'package:work_match_app/data/models/user_model.dart';
import 'package:work_match_app/ui/controllers/auth_controller.dart';
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
  final AuthController _authController = AuthController();
  bool _isLoading = false;

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
                    child: CustomButton(text: "Entrar", onPressed: () => _isLoading ? null : _loginUser()),
                  ),
                  const SizedBox(height: 16),

                  // Cadastro
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/account_type'),
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

  Future<void> _loginUser() async {
    setState(() => _isLoading = true);

    try {
      UserModel userModel = await _authController.login(_emailController.text.trim(), _passwordController.text.trim());

      if (!mounted) return;

      SnackbarHelper.showSuccess(context, "Login realizado com sucesso!");

      if (userModel.tipo == 'contratante') {
        Navigator.pushReplacementNamed(context, '/contratante/home');
      } else {
        Navigator.pushReplacementNamed(context, '/contratado/home');
      }
    } catch (e) {
      if (!mounted) return;
      SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
