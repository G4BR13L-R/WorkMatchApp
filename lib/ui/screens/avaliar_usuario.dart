import 'package:flutter/material.dart';
import 'package:work_match_app/core/utils/snackbar_helper.dart';

class AvaliarUsuario extends StatefulWidget {
  const AvaliarUsuario({super.key});

  @override
  State<AvaliarUsuario> createState() => _AvaliarUsuarioState();
}

class _AvaliarUsuarioState extends State<AvaliarUsuario> {
  final TextEditingController _motivoController = TextEditingController();
  double _nota = 0;
  bool _isLoading = false;

  Widget _buildEstrelas() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final i = index + 1;
        return IconButton(
          icon: Icon(i <= _nota ? Icons.star : Icons.star_border, color: Colors.amber, size: 36),
          onPressed: () => setState(() => _nota = i.toDouble()),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Avaliar Usuário'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Selecione a nota:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildEstrelas(),
            const SizedBox(height: 30),
            const Text('Motivo:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(
              controller: _motivoController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Descreva o motivo da sua avaliação...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _isLoading ? null : _enviarAvaliacao,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child:
                  _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Enviar Avaliação', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _enviarAvaliacao() async {
    if (_nota == 0) {
      SnackbarHelper.showError(context, 'Selecione uma nota antes de enviar.');
      return;
    }

    if (_motivoController.text.trim().isEmpty) {
      SnackbarHelper.showError(context, 'Informe o motivo da avaliação.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return;

      SnackbarHelper.showSuccess(context, 'Avaliação enviada com sucesso!');
      Navigator.pop(context);
    } catch (e) {
      if (mounted) SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
