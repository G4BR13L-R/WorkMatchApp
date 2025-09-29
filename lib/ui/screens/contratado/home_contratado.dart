import 'package:flutter/material.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/ui/widgets/custom_button.dart';

class HomeContratado extends StatelessWidget {
  const HomeContratado({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/contratado/profile'),
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),

              Icon(Icons.construction_rounded, size: 120, color: AppColors.primary),
              const SizedBox(height: 50),

              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  text: "Lista de Ofertas",
                  onPressed: () {
                    // Ação ofertas feitas
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
