import 'dart:convert';

import 'package:work_match_app/core/models/avaliacao_model.dart';
import 'package:work_match_app/core/services/api_client.dart';
import 'package:work_match_app/core/utils/throw_exception.dart';

class AvaliacaoService {
  Future<AvaliacaoModel?> show(
    int autorId,
    String autorTipo,
    int destinatarioId,
    String destinatarioTipo,
    int ofertaId,
  ) async {
    String paramsUrl = '?autor_id=$autorId';
    paramsUrl += '&autor_tipo=$autorTipo';
    paramsUrl += '&destinatario_id=$destinatarioId';
    paramsUrl += '&destinatario_tipo=$destinatarioTipo';
    paramsUrl += '&oferta_id=$ofertaId';

    final response = await ApiClient.get('/avaliacoes?$paramsUrl');

    if (response.statusCode != 200) return ThrowException.request(response.body);

    final data = jsonDecode(response.body);
    return (data is Map && data.isEmpty) ? null : AvaliacaoModel.fromJson(data);
  }

  Future<AvaliacaoModel> store(
    int autorId,
    String autorTipo,
    int destinatarioId,
    String destinatarioTipo,
    int ofertaId,
    int nota,
    String? comentario,
  ) async {
    final response = await ApiClient.post('/avaliacoes', {
      'autor_id': autorId,
      'autor_tipo': autorTipo,
      'destinatario_id': destinatarioId,
      'destinatario_tipo': destinatarioTipo,
      'oferta_id': ofertaId,
      'nota': nota,
      'comentario': comentario,
    });

    if (response.statusCode != 201) return ThrowException.request(response.body);

    final data = jsonDecode(response.body);
    return AvaliacaoModel.fromJson(data);
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
  ) async {
    final response = await ApiClient.put('/avaliacoes/$id', {
      'autor_id': autorId,
      'autor_tipo': autorTipo,
      'destinatario_id': destinatarioId,
      'destinatario_tipo': destinatarioTipo,
      'oferta_id': ofertaId,
      'nota': nota,
      'comentario': comentario,
    });

    if (response.statusCode != 200) return ThrowException.request(response.body);

    return true;
  }

  Future<bool> destroy(int id) async {
    final response = await ApiClient.delete('/avaliacoes/$id');

    if (response.statusCode != 200) return ThrowException.request(response.body);

    return true;
  }
}
