import 'package:work_match_app/core/models/avaliacao_model.dart';
import 'package:work_match_app/core/services/avaliacao_service.dart';

class AvaliacaoController {
  final AvaliacaoService _avaliacaoService = AvaliacaoService();

  Future<AvaliacaoModel?> show(
    int autorId,
    String autorTipo,
    int destinatarioId,
    String destinatarioTipo,
    int ofertaId,
  ) async {
    return await _avaliacaoService.show(autorId, autorTipo, destinatarioId, destinatarioTipo, ofertaId);
  }

  Future<AvaliacaoModel> register(
    int autorId,
    String autorTipo,
    int destinatarioId,
    String destinatarioTipo,
    int ofertaId,
    int nota,
    String? comentario,
  ) async {
    return await _avaliacaoService.store(
      autorId,
      autorTipo,
      destinatarioId,
      destinatarioTipo,
      ofertaId,
      nota,
      comentario,
    );
  }

  Future<bool> update(
    int id,
    int autorId,
    String autorTipo,
    int destinatarioId,
    String destinatarioTipo,
    int ofertaId,
    int nota,
    String? comentario,
  ) {
    return _avaliacaoService.update(
      id,
      autorId,
      autorTipo,
      destinatarioId,
      destinatarioTipo,
      ofertaId,
      nota,
      comentario,
    );
  }

  Future<bool> destroy(int id) {
    return _avaliacaoService.destroy(id);
  }
}
