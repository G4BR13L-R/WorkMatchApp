import 'package:flutter/material.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/ui/widgets/custom_button.dart';

class AccountType extends StatelessWidget {
  const AccountType({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Tipo de conta", style: AppTextStyles.title.copyWith(fontSize: 32)),
                const SizedBox(height: 40),

                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: "Contratante",
                    onPressed: () => Navigator.pushNamed(context, '/contratante/register'),
                  ),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: "Contratado",
                    onPressed: () => Navigator.pushNamed(context, '/contratado/register'),
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
