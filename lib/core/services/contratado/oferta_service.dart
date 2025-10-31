import 'dart:convert';

import 'package:work_match_app/core/models/candidatura_model.dart';
import 'package:work_match_app/core/models/oferta_model.dart';
import 'package:work_match_app/core/services/api_client.dart';
import 'package:work_match_app/core/utils/throw_exception.dart';

class OfertaService {
  Future<List<OfertaModel>> index({bool? status, int? cidadeId}) async {
    final finalizada = status == null ? '' : (status ? 'true' : 'false');
    final cidade = cidadeId == null ? '' : cidadeId.toString();

    final response = await ApiClient.get('/contratado/ofertas?finalizada=$finalizada&cidade_id=$cidade');

    if (response.statusCode != 200) ThrowException.request(response.body);

    final data = jsonDecode(response.body);

    return data.map<OfertaModel>((item) => OfertaModel.fromJson(item)).toList();
  }

  Future<OfertaModel> show(int id) async {
    final response = await ApiClient.get('/contratado/ofertas/$id');

    if (response.statusCode != 200) ThrowException.request(response.body);

    final data = jsonDecode(response.body);
    return OfertaModel.fromJson(data);
  }

  Future<CandidaturaModel> registerCandidatura(int ofertaId, double? salario) async {
    final response = await ApiClient.post('/contratado/candidaturas', {'oferta_id': ofertaId, 'salario': salario});

    if (response.statusCode != 201) ThrowException.request(response.body);

    final data = jsonDecode(response.body);

    return CandidaturaModel.fromJson(data);
  }

  Future<bool> deleteCandidatura(int id) async {
    final response = await ApiClient.delete('/contratado/candidaturas/$id');

    if (response.statusCode != 200) ThrowException.request(response.body);

    return true;
  }
}
