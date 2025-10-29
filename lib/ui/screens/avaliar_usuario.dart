import 'package:flutter/material.dart';
import 'package:work_match_app/core/controllers/avaliacao_controller.dart';
import 'package:work_match_app/core/theme/app_colors.dart';
import 'package:work_match_app/core/theme/app_text_styles.dart';
import 'package:work_match_app/core/utils/snackbar_helper.dart';
import 'package:work_match_app/ui/widgets/custom_button.dart';
import 'package:work_match_app/ui/widgets/custom_text_field.dart';

class AvaliarUsuario extends StatefulWidget {
  const AvaliarUsuario({super.key});

  @override
  State<AvaliarUsuario> createState() => _AvaliarUsuarioState();
}

class _AvaliarUsuarioState extends State<AvaliarUsuario> {
  final TextEditingController _motivoController = TextEditingController();

  int? _id;
  int? _autorId;
  String? _autorTipo;
  int? _destinatarioId;
  String? _destinatarioTipo;
  int? _ofertaId;
  int _nota = 0;

  final AvaliacaoController _avaliacaoController = AvaliacaoController();

  bool _isFetching = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;

      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

      _autorId = args?['autor_id'] as int?;
      _autorTipo = args?['autor_tipo'] as String?;
      _destinatarioId = args?['destinatario_id'] as int?;
      _destinatarioTipo = args?['destinatario_tipo'] as String?;
      _ofertaId = args?['oferta_id'] as int?;

      if (_autorId != null &&
          _autorTipo != null &&
          _destinatarioId != null &&
          _destinatarioTipo != null &&
          _ofertaId != null) {
        _loadAvaliacao(_autorId!, _autorTipo!, _destinatarioId!, _destinatarioTipo!, _ofertaId!);
      }
    });
  }

  Future<void> _loadAvaliacao(
    int autorId,
    String autorTipo,
    int destinatarioId,
    String destinatarioTipo,
    int ofertaId,
  ) async {
    setState(() => _isFetching = true);

    try {
      final avaliacao = await _avaliacaoController.show(autorId, autorTipo, destinatarioId, destinatarioTipo, ofertaId);

      if (mounted) {
        setState(() {
          _id = avaliacao?.id;
          _nota = avaliacao?.nota ?? 0;
          _motivoController.text = avaliacao?.comentario ?? '';
        });
      }
    } catch (e) {
      if (mounted) SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      if (mounted) setState(() => _isFetching = false);
    }
  }

  Widget _buildEstrelas() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final i = index + 1;
        return IconButton(
          icon: Icon(i <= _nota ? Icons.star : Icons.star_border, color: Colors.amber, size: 36),
          onPressed: () => setState(() => _nota = i),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isFetching) {
      return const Scaffold(backgroundColor: AppColors.background, body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text("Avaliar Usuário", style: AppTextStyles.title.copyWith(fontSize: 22)),
        iconTheme: const IconThemeData(color: AppColors.textLight),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Selecione a nota:', style: AppTextStyles.subtitle),
              const SizedBox(height: 10),
              _buildEstrelas(),

              const SizedBox(height: 30),
              const Text('Motivo:', style: AppTextStyles.subtitle),
              const SizedBox(height: 10),

              CustomTextField(
                hintText: 'Descreva o motivo da sua avaliação',
                icon: Icons.text_fields,
                controller: _motivoController,
                minLine: 8,
                maxLine: null,
              ),

              Spacer(),

              CustomButton(
                text: 'Enviar Avaliação',
                backgroundColor: AppColors.primary,
                onPressed: _isLoading ? null : _enviarAvaliacao,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _enviarAvaliacao() async {
    if (_autorId == null || _autorTipo == null) {
      SnackbarHelper.showError(context, 'Autor Inválido');
      return;
    }

    if (_destinatarioId == null || _destinatarioTipo == null) {
      SnackbarHelper.showError(context, 'Destinatário Inválido');
      return;
    }

    if (_ofertaId == null) {
      SnackbarHelper.showError(context, 'Oferta Inválida');
      return;
    }

    if (_nota == 0) {
      SnackbarHelper.showError(context, 'Selecione uma nota antes de enviar.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (_id == null) {
        await _avaliacaoController.register(
          _autorId!,
          _autorTipo!,
          _destinatarioId!,
          _destinatarioTipo!,
          _ofertaId!,
          _nota,
          _motivoController.text,
        );
      } else {
        await _avaliacaoController.update(
          _id!,
          _autorId!,
          _autorTipo!,
          _destinatarioId!,
          _destinatarioTipo!,
          _ofertaId!,
          _nota,
          _motivoController.text,
        );
      }

      if (!mounted) return;

      SnackbarHelper.showSuccess(
        context,
        _id == null ? 'Avaliação enviada com sucesso!' : 'Avaliação atualizada com sucesso!',
      );

      Navigator.pop(context);
    } catch (e) {
      if (mounted) SnackbarHelper.showError(context, e.toString().replaceFirst('Exception: ', ''));
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
