import 'dart:convert';
import 'package:work_match_app/core/models/oferta_model.dart';
import 'package:work_match_app/core/services/api_client.dart';
import 'package:work_match_app/core/utils/throw_exception.dart';

class OfertaService {
  Future<OfertaModel> store(
    String titulo,
    String descricao,
    double salario,
    String dataInicio,
    String dataFim,
    String logradouro,
    String numero,
    String complemento,
    String bairro,
    int cidadeID,
  ) async {
    final response = await ApiClient.post('/contratante/ofertas', {
      'titulo': titulo,
      'descricao': descricao,
      'salario': salario,
      'data_inicio': dataInicio,
      'data_fim': dataFim,
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cidade_id': cidadeID,
    });

    if (response.statusCode != 201) ThrowException.request(response.body);

    final data = jsonDecode(response.body);
    return OfertaModel.fromJson(data);
  }

  Future<bool> update(
    int id,
    String titulo,
    String descricao,
    double salario,
    String dataInicio,
    String dataFim,
    String logradouro,
    String numero,
    String complemento,
    String bairro,
    int cidadeID,
  ) async {
    final response = await ApiClient.put('/contratante/ofertas/$id', {
      'titulo': titulo,
      'descricao': descricao,
      'salario': salario,
      'data_inicio': dataInicio,
      'data_fim': dataFim,
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cidade_id': cidadeID,
    });

    if (response.statusCode != 200) return ThrowException.request(response.body);

    return true;
  }

  Future<bool> destroy(int id) async {
    final response = await ApiClient.delete('/contratante/ofertas/$id');

    if (response.statusCode != 200) return ThrowException.request(response.body);

    return true;
  }
}
