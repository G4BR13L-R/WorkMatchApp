import 'package:work_match_app/data/models/cidade_model.dart';

class EnderecoModel {
  final int? id;
  final String logradouro;
  final String numero;
  final String complemento;
  final String bairro;
  final int cidadeId;
  final CidadeModel? cidade;

  EnderecoModel({
    this.id,
    required this.logradouro,
    required this.numero,
    required this.complemento,
    required this.bairro,
    required this.cidadeId,
    this.cidade,
  });

  factory EnderecoModel.fromJson(Map<String, dynamic> json) {
    return EnderecoModel(
      id: json['id'],
      logradouro: json['logradouro'],
      numero: json['numero'],
      complemento: json['complemento'],
      bairro: json['bairro'],
      cidadeId: json['cidade_id'],
      cidade: CidadeModel.fromJson(json['cidade'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> dadosEndereco = {
      'id': id,
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cidade_id': cidadeId,
      'cidade': cidade?.toJson(),
    };

    return dadosEndereco;
  }
}
