import 'dart:convert';

import 'package:work_match_app/core/models/candidatura_model.dart';
import 'package:work_match_app/core/services/api_client.dart';
import 'package:work_match_app/core/utils/throw_exception.dart';

class CandidaturaService {
  Future<List<CandidaturaModel>> index(int ofertaId) async {
    final response = await ApiClient.get('/contratante/ofertas/$ofertaId/candidaturas');

    if (response.statusCode != 200) ThrowException.request(response.body);

    final data = jsonDecode(response.body);

    return data.map<CandidaturaModel>((item) => CandidaturaModel.fromJson(item)).toList();
  }

  Future<CandidaturaModel> show(int id) async {
    final response = await ApiClient.get('/contratante/candidaturas/$id');

    if (response.statusCode != 200) ThrowException.request(response.body);

    final data = jsonDecode(response.body);
    return CandidaturaModel.fromJson(data);
  }

  Future<bool> changeStatus(int id, int status) async {
    final response = await ApiClient.put('/contratante/candidaturas/$id', {'status_id': status});

    if (response.statusCode != 200) return ThrowException.request(response.body);

    return true;
  }
}
