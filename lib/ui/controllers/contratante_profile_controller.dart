import 'package:work_match_app/data/models/contratante_model.dart';
import 'package:work_match_app/data/repositories/contratante_profile_repository.dart';

class ContratanteProfileController {
  final ContratanteProfileRepository contratanteProfileRepository = ContratanteProfileRepository();

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

    ContratanteModel contratante = ContratanteModel(
      nome: nome,
      telefone: telefone,
      cnpj: cnpj,
      razaoSocial: razaoSocial,
      nomeFantasia: nomeFantasia,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );

    return await contratanteProfileRepository.register(contratante);
  }
}
