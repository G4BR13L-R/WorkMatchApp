import 'package:work_match_app/core/models/user_model.dart';
import 'package:work_match_app/core/services/auth_service.dart';

class AuthController {
  final AuthService _repository = AuthService();

  Future<UserModel> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception("Preencha todos os campos");
    }

    return await _repository.login(email, password);
  }

  Future<bool> logout() async {
    return await _repository.logout();
  }
}
