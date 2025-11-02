import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:work_match_app/core/controllers/contratado/profile_controller.dart';
import 'package:work_match_app/core/models/cidade_model.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/core/utils/snackbar_helper.dart';
import 'package:work_match_app/ui/widgets/cidade_autocomplete.dart';
import 'package:work_match_app/ui/widgets/custom_button.dart';
import 'package:work_match_app/ui/widgets/custom_text_field.dart';

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
  CidadeModel? _cidadeSelecionada;

  final ProfileController _contratadoProfileController = ProfileController();
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
    _cidadeSelecionada = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text("Contratado", style: AppTextStyles.title.copyWith(fontSize: 22)),
        iconTheme: const IconThemeData(color: AppColors.textLight),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    CustomTextField(hintText: "Nome", icon: Icons.person, controller: _nomeController),
                    const SizedBox(height: 16),

                    CustomTextField(
                      hintText: "Telefone",
                      icon: Icons.phone,
                      controller: _telefoneController,
                      inputFormatters: [
                        MaskTextInputFormatter(mask: '(##) #####-####', filter: {"#": RegExp(r'[0-9]')}),
                      ],
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      hintText: "Data de Nascimento",
                      icon: Icons.calendar_month,
                      controller: _dataNascimentoController,
                      inputFormatters: [
                        MaskTextInputFormatter(mask: '##/##/####', filter: {"#": RegExp(r'[0-9]')}),
                      ],
                      keyboardType: TextInputType.datetime,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      hintText: "CPF",
                      icon: Icons.person,
                      controller: _cpfController,
                      inputFormatters: [
                        MaskTextInputFormatter(mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')}),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),

                    CustomTextField(
                      hintText: "RG",
                      icon: Icons.badge,
                      controller: _rgController,
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),

                    CidadeAutoComplete(
                      initialValue: _cidadeSelecionada,
                      onSelected: (cidade) {
                        setState(() => _cidadeSelecionada = cidade);
                      },
                    ),
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
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                child: CustomButton(text: "Cadastrar", onPressed: () => _isLoading ? null : _registerContratante()),
              ),
            ),
          ],
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
        _cidadeSelecionada?.id,
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
