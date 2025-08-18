import 'dart:convert';

import 'package:work_match_app/core/services/api_client.dart';
import 'package:work_match_app/core/services/secure_storage_service.dart';
import 'package:work_match_app/data/models/contratante_model.dart';

class ContratanteProfileRepository {
  Future<void> shows() async {}

  Future<ContratanteModel> register(ContratanteModel contratanteModel) async {
    final response = await ApiClient.post('/contratante/perfil', contratanteModel.toJson());

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      if (token == null) {
        throw Exception('Token de autenticação não encontrado.');
      }

      await SecureStorageService.saveToken(token);
      return ContratanteModel.fromJson(data['contratante']);
    }

    Map<String, dynamic> errorData;

    try {
      errorData = jsonDecode(response.body);
    } catch (e) {
      throw Exception('Erro de comunicação com o servidor.');
    }

    if (errorData.containsKey('errors')) {
      final firstKey = errorData['errors'].keys.first;
      final firstError = errorData['errors'][firstKey][0];

      throw Exception(firstError);
    } else {
      throw Exception(errorData['message'] ?? 'Ocorreu um erro desconhecido.');
    }
  }

  Future<void> update() async {}

  Future<void> updatePassword() async {}

  Future<void> delete() async {}
}
