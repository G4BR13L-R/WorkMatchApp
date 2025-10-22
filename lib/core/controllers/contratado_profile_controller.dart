import 'package:work_match_app/core/models/contratado_model.dart';
import 'package:work_match_app/core/services/contratado/profile_service.dart';
import 'package:work_match_app/core/utils/format_helper.dart';

class ContratadoProfileController {
  final ProfileService _profileService = ProfileService();

  Future<ContratadoModel> show() async {
    return await _profileService.show();
  }

  Future<ContratadoModel> register(
    String nome,
    String telefone,
    String dataNascimento,
    String cpf,
    String rg,
    String email,
    String password,
    String passwordConfirmation,
  ) async {
    if (nome.isEmpty) throw Exception("O campo nome é obrigatório");
    if (telefone.isEmpty) throw Exception("o campo telefone é obrigatório");
    if (dataNascimento.isEmpty) throw Exception("o campo data de nascimento é obrigatório");
    if (dataNascimento.length < 10) throw Exception("o campo data de nascimento é inválido");
    if (cpf.isEmpty) throw Exception("o campo CPF é obrigatório");
    if (email.isEmpty) throw Exception("o campo email é obrigatório");
    if (password.isEmpty) throw Exception("o campo senha é obrigatório");
    if (passwordConfirmation.isEmpty) throw Exception("o campo confirmação de senha é obrigatório");

    dataNascimento = FormatHelper.formatDateToAPI(dataNascimento);

    return await _profileService.store(nome, telefone, dataNascimento, cpf, rg, email, password, passwordConfirmation);
  }

  Future<bool> update(
    String nome,
    String telefone,
    String email,
    String dataNascimento,
    String cpf,
    String rg,
    String? logradouro,
    String? numero,
    String? complemento,
    String? bairro,
    int? cidadeId,
  ) async {
    if (nome.isEmpty) throw Exception("O campo nome é obrigatório");
    if (telefone.isEmpty) throw Exception("o campo telefone é obrigatório");
    if (dataNascimento.isEmpty) throw Exception("o campo data de nascimento é obrigatório");
    if (dataNascimento.length < 10) throw Exception("o campo data de nascimento é inválido");
    if (cpf.isEmpty) throw Exception("o campo CPF é obrigatório");
    if (email.isEmpty) throw Exception("o campo email é obrigatório");

    dataNascimento = FormatHelper.formatDateToAPI(dataNascimento);

    return await _profileService.update(
      nome,
      telefone,
      email,
      dataNascimento,
      cpf,
      rg,
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

    return await _profileService.updatePassword(currentPassword, newPassword, newPasswordConfirmation);
  }

  Future<bool> delete(currentPassword) async {
    if (currentPassword.isEmpty) throw Exception("O campo senha atual é obrigatório");

    return await _profileService.delete(currentPassword);
  }
}
