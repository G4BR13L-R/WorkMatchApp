import 'dart:convert';

class ThrowException {
  static request(String response) {
    Map<String, dynamic> errorData;

    try {
      errorData = jsonDecode(response);
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
