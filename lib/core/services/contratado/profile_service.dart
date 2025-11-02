import 'dart:convert';

import 'package:work_match_app/core/models/contratado_model.dart';
import 'package:work_match_app/core/services/api_client.dart';
import 'package:work_match_app/core/services/secure_storage_service.dart';

class ProfileService {
  Future<ContratadoModel> show() async {
    final response = await ApiClient.get('/contratado/perfil');

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return ContratadoModel.fromJson(data);
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

  Future<ContratadoModel> store(
    String nome,
    String telefone,
    String dataNascimento,
    String cpf,
    String? rg,
    int cidadeId,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    final response = await ApiClient.post('/contratado/perfil', {
      'nome': nome,
      'telefone': telefone,
      'data_nascimento': dataNascimento,
      'cpf': cpf,
      'rg': rg,
      'cidade_id': cidadeId,
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

      await SecureStorageService.saveAuthData(token, 'contratado');
      return ContratadoModel.fromJson(data['contratado']);
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
    String dataNascimento,
    String cpf,
    String? rg,
    String? formacoes,
    String? habilidades,
    String? experiencias,
    String? logradouro,
    String? numero,
    String? complemento,
    String? bairro,
    int? cidadeId,
  ) async {
    final response = await ApiClient.put('/contratado/perfil', {
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'data_nascimento': dataNascimento,
      'cpf': cpf,
      'rg': rg,
      'formacoes': formacoes,
      'habilidades': habilidades,
      'experiencias': experiencias,
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cidade_id': cidadeId,
    });

    if (response.statusCode == 200) return true;

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

  Future<bool> updatePassword(String currentPassword, String newPassword, String newPasswordConfirmation) async {
    final response = await ApiClient.put('/contratado/perfil/senha', {
      'current_password': currentPassword,
      'new_password': newPassword,
      'new_password_confirmation': newPasswordConfirmation,
    });

    if (response.statusCode == 200) return true;

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

  Future<bool> delete(currentPassword) async {
    final response = await ApiClient.delete('/contratado/perfil', body: {'current_password': currentPassword});

    if (response.statusCode == 200) {
      await SecureStorageService.deleteAuthData();
      return true;
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
}
