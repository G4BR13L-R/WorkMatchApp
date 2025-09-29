import 'package:work_match_app/data/models/contratante_model.dart';
import 'package:work_match_app/core/services/contratante_profile_service.dart';

class ContratanteProfileController {
  final ContratanteProfileService contratanteProfileRepository = ContratanteProfileService();

  Future<ContratanteModel> show() async {
    return await contratanteProfileRepository.show();
  }

  Future<ContratanteModel> register(
    String nome,
    String telefone,
    String cnpj,
    String razaoSocial,
    String nomeFantasia,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    if (nome.isEmpty) throw Exception("O campo nome é obrigatório");
    if (telefone.isEmpty) throw Exception("o campo telefone é obrigatório");
    if (cnpj.isEmpty) throw Exception("o campo cnpj é obrigatório");
    if (razaoSocial.isEmpty) throw Exception("o campo razão social é obrigatório");
    if (email.isEmpty) throw Exception("o campo email é obrigatório");
    if (password.isEmpty) throw Exception("o campo senha é obrigatório");
    if (passwordConfirmation.isEmpty) throw Exception("o campo confirmação de senha é obrigatório");

    return await contratanteProfileRepository.store(
      nome,
      telefone,
      cnpj,
      razaoSocial,
      nomeFantasia,
      email,
      password,
      passwordConfirmation,
    );
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
    if (nome.isEmpty) throw Exception("O campo nome é obrigatório");
    if (telefone.isEmpty) throw Exception("o campo telefone é obrigatório");
    if (cnpj.isEmpty) throw Exception("o campo cnpj é obrigatório");
    if (razaoSocial.isEmpty) throw Exception("o campo razão social é obrigatório");
    if (email.isEmpty) throw Exception("o campo email é obrigatório");

    return await contratanteProfileRepository.update(
      nome,
      telefone,
      email,
      cnpj,
      razaoSocial,
      nomeFantasia,
      logradouro,
      numero,
      complemento,
      bairro,
      cidadeId,
    );
  }

  Future<bool> updatePassword(currentPassword, newPassword, newPasswordConfirmation) async {
    if (currentPassword.isEmpty) throw Exception("O campo senha atual é obrigatório");
    if (newPassword.isEmpty) throw Exception("o campo nova senha é obrigatório");
    if (newPasswordConfirmation.isEmpty) throw Exception("o campo confirmação de nova senha é obrigatório");

    return await contratanteProfileRepository.updatePassword(currentPassword, newPassword, newPasswordConfirmation);
  }

  Future<bool> delete(currentPassword) async {
    if (currentPassword.isEmpty) throw Exception("O campo senha atual é obrigatório");

    return await contratanteProfileRepository.delete(currentPassword);
  }
}
