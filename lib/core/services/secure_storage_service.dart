import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'auth_token';
  static const _typeKey = 'user_type';

  static Future<void> saveAuthData(String token, String type) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _typeKey, value: type);
  }

  static Future<Map<String, dynamic>> getAuthData() async {
    String? token = await _storage.read(key: _tokenKey);
    String? type = await _storage.read(key: _typeKey);

    return {'token': token, 'type': type};
  }

  static Future<void> deleteAuthData() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _typeKey);
  }
}
