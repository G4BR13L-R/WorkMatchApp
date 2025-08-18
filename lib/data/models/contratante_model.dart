import 'package:work_match_app/data/models/endereco_model.dart';

class ContratanteModel {
  final int? id;
  final String nome;
  final String telefone;
  final String cnpj;
  final String razaoSocial;
  final String nomeFantasia;
  final String email;
  final String? password;
  final String? passwordConfirmation;
  final EnderecoModel? endereco;

  ContratanteModel({
    this.id,
    required this.nome,
    required this.telefone,
    required this.cnpj,
    required this.razaoSocial,
    required this.nomeFantasia,
    required this.email,
    this.password,
    this.passwordConfirmation,
    this.endereco,
  });

  factory ContratanteModel.fromJson(Map<String, dynamic> json) {
    return ContratanteModel(
      id: json['id'],
      nome: json['nome'],
      telefone: json['telefone'],
      cnpj: json['cnpj'],
      razaoSocial: json['razao_social'],
      nomeFantasia: json['nome_fantasia'],
      email: json['email'],
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
      endereco: EnderecoModel.fromJson(json['endereco'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> dadosContratante = {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'cnpj': cnpj,
      'razao_social': razaoSocial,
      'nome_fantasia': nomeFantasia,
      'email': email,
    };

    if (password != null) {
      dadosContratante['password'] = password;
    }

    if (passwordConfirmation != null) {
      dadosContratante['password_confirmation'] = passwordConfirmation;
    }

    if (endereco != null) {
      dadosContratante = {...dadosContratante, ...endereco!.toJson()};
    }

    return dadosContratante;
  }
}
