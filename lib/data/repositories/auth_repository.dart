import 'dart:convert';
import 'package:work_match_app/core/services/api_client.dart';
import 'package:work_match_app/core/services/secure_storage_service.dart';
import 'package:work_match_app/data/models/user_model.dart';

class AuthRepository {
  Future<UserModel> login(String email, String password) async {
    final response = await ApiClient.post('/sessions', {'email': email, 'password': password});

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      if (token == null) {
        throw Exception('Token de autenticação não encontrado.');
      }

      await SecureStorageService.saveToken(token);
      return UserModel.fromJson(data['user']);
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

  Future<bool> logout() async {
    final response = await ApiClient.delete('/sessions');
    await SecureStorageService.deleteToken();
    return response.statusCode == 200;
  }
}
