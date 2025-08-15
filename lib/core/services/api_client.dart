import 'dart:convert';
import 'package:http/http.dart' as http;
import 'secure_storage_service.dart';

class ApiClient {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  static Future<Map<String, String>> _buildHeaders() async {
    final token = await SecureStorageService.getToken();
    
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  static Uri _buildUri(String endpoint) {
    return Uri.parse('$baseUrl$endpoint');
  }

  static Future<http.Response> get(String endpoint) async {
    final headers = await _buildHeaders();
    return await http.get(_buildUri(endpoint), headers: headers);
  }

  static Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final headers = await _buildHeaders();
    return await http.post(_buildUri(endpoint), headers: headers, body: jsonEncode(body));
  }

  static Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final headers = await _buildHeaders();
    return await http.put(_buildUri(endpoint), headers: headers, body: jsonEncode(body));
  }

  static Future<http.Response> delete(String endpoint, {Map<String, dynamic>? body}) async {
    final headers = await _buildHeaders();
    return await http.delete(_buildUri(endpoint), headers: headers, body: body != null ? jsonEncode(body) : null);
  }
}
