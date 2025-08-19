import 'dart:convert';
import 'package:work_match_app/core/services/api_client.dart';
import 'package:work_match_app/core/services/secure_storage_service.dart';
import 'package:work_match_app/data/models/contratante_model.dart';

class ContratanteProfileRepository {
  Future<ContratanteModel> show() async {
    final response = await ApiClient.get('/contratante/perfil');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ContratanteModel.fromJson(data);
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

  Future<ContratanteModel> store(
    String nome,
    String telefone,
    String cnpj,
    String razaoSocial,
    String nomeFantasia,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    final response = await ApiClient.post('/contratante/perfil', {
      'nome': nome,
      'telefone': telefone,
      'cnpj': cnpj,
      'razao_social': razaoSocial,
      'nome_fantasia': nomeFantasia,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    });

    if (response.statusCode == 201) {
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

  Future<bool> update(
    String nome,
    String telefone,
    String email,
    String cnpj,
    String razaoSocial,
    String nomeFantasia,
    String? logradouro,
    String? numero,
    String? complemento,
    String? bairro,
    int? cidadeId,
  ) async {
    final response = await ApiClient.put('/contratante/perfil', {
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'cnpj': cnpj,
      'razao_social': razaoSocial,
      'nome_fantasia': nomeFantasia,
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cidade_id': cidadeId,
    });

    bool status = response.statusCode == 200 ? true : false;

    return status;
  }

  Future<bool> updatePassword(String currentPassword, String newPassword, String newPasswordConfirmation) async {
    final response = await ApiClient.put('/contratante/perfil/senha', {
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': newPasswordConfirmation,
    });

    bool status = response.statusCode == 200 ? true : false;

    return status;
  }

  Future<bool> delete() async {
    final response = await ApiClient.delete('/contratante/perfil');

    bool status = response.statusCode == 200 ? true : false;
    if (status) await SecureStorageService.deleteToken();

    return status;
  }
}
