import 'package:work_match_app/core/models/endereco_model.dart';

class ContratadoModel {
  final int? id;
  final String nome;
  final String telefone;
  final String dataNascimento;
  final String cpf;
  final String? rg;
  final String? formacoes;
  final String? habilidades;
  final String? experiencias;
  final String email;
  final String? password;
  final String? passwordConfirmation;
  final EnderecoModel? endereco;

  ContratadoModel({
    this.id,
    required this.nome,
    required this.telefone,
    required this.dataNascimento,
    required this.cpf,
    this.rg,
    this.formacoes,
    this.habilidades,
    this.experiencias,
    required this.email,
    this.password,
    this.passwordConfirmation,
    this.endereco,
  });

  factory ContratadoModel.fromJson(Map<String, dynamic> json) {
    return ContratadoModel(
      id: json['id'],
      nome: json['nome'],
      telefone: json['telefone'],
      dataNascimento: json['data_nascimento'],
      cpf: json['cpf'],
      rg: json['rg'],
      formacoes: json['formacoes'],
      habilidades: json['habilidades'],
      experiencias: json['experiencias'],
      email: json['email'],
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
      endereco: json['endereco'] != null ? EnderecoModel.fromJson(json['endereco']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> dadosContratante = {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'data_nascimento': dataNascimento,
      'cpf': cpf,
      'rg': rg,
      'formacoes': formacoes,
      'habilidades': habilidades,
      'experiencias': experiencias,
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
