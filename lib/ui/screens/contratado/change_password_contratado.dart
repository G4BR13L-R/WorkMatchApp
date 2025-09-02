import 'package:flutter/material.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/core/utils/snackbar_helper.dart';
import 'package:work_match_app/ui/controllers/contratado_profile_controller.dart';
import 'package:work_match_app/ui/screens/widgets/custom_button.dart';
import 'package:work_match_app/ui/screens/widgets/custom_text_field.dart';

class ChangePasswordContratado extends StatefulWidget {
  const ChangePasswordContratado({super.key});

  @override
  State<ChangePasswordContratado> createState() => _ChangePasswordContratadoState();
}

class _ChangePasswordContratadoState extends State<ChangePasswordContratado> {
  final TextEditingController _currentPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();
  final TextEditingController _confirmNewPassword = TextEditingController();
  final ContratadoProfileController _contratadoProfileController = ContratadoProfileController();
  bool _isLoading = false;

  @override
  void dispose() {
    _currentPassword.dispose();
    _newPassword.dispose();
    _confirmNewPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text("Alterar Senha", style: AppTextStyles.title.copyWith(fontSize: 22)),
        iconTheme: const IconThemeData(color: AppColors.textLight),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              CustomTextField(
                hintText: "Senha Atual",
                obscureText: true,
                icon: Icons.lock_clock,
                controller: _currentPassword,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                hintText: "Nova Senha",
                obscureText: true,
                icon: Icons.lock_open,
                controller: _newPassword,
              ),
              const SizedBox(height: 16),

              CustomTextField(
                hintText: "Confirmar Nova Senha",
                obscureText: true,
                icon: Icons.lock_outline,
                controller: _confirmNewPassword,
              ),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                child: CustomButton(text: "Atualizar Senha", onPressed: () => _isLoading ? null : _updatePassword()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updatePassword() async {
    setState(() => _isLoading = true);

    try {
      bool status = await _contratadoProfileController.updatePassword(
        _currentPassword.text.trim(),
        _newPassword.text.trim(),
        _confirmNewPassword.text.trim(),
      );

      if (!mounted) return;

      if (!status) {
        SnackbarHelper.showError(context, "Falha ao atualizar senha!");
        return;
      }

      SnackbarHelper.showSuccess(context, "Senha atualizada com sucesso!");
      Navigator.pushNamed(context, '/contratado/profile');
    } catch (e) {
      if (!mounted) return;
      SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
