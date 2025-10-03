import 'package:flutter/material.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/ui/widgets/oferta_card.dart';

class HomeContratante extends StatelessWidget {
  const HomeContratante({super.key});

  final List<Map<String, String>> ofertas = const [
    {"titulo": "Serviço de Limpeza", "descricao": "Limpeza residencial completa, rápida e eficiente."},
    {"titulo": "Reforma Elétrica", "descricao": "Instalação e manutenção de circuitos elétricos."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => Navigator.pushNamed(context, '/contratante/oferta'),
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/contratante/profile'),
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.primary,
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              if (ofertas.isEmpty)
                Expanded(child: Center(child: Text("Nenhuma oferta cadastrada", style: AppTextStyles.subtitle)))
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: ofertas.length,
                    itemBuilder: (context, index) {
                      final oferta = ofertas[index];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: OfertaCard(
                          titulo: oferta["titulo"]!,
                          descricao: oferta["descricao"]!,
                          onEditar: () {
                            // Ação editar
                          },
                          onExcluir: () {
                            // Ação excluir
                          },
                        ),
                      );
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
