import 'package:work_match_app/data/models/cidade_model.dart';

class EnderecoModel {
  final int? id;
  final String? logradouro;
  final String? numero;
  final String? complemento;
  final String? bairro;
  final CidadeModel? cidade;

  EnderecoModel({this.id, this.logradouro, this.numero, this.complemento, this.bairro, this.cidade});

  factory EnderecoModel.fromJson(Map<String, dynamic> json) {
    return EnderecoModel(
      id: json['id'],
      logradouro: json['logradouro'],
      numero: json['numero'],
      complemento: json['complemento'],
      bairro: json['bairro'],
      cidade: json['cidade'] != null ? CidadeModel.fromJson(json['cidade']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> dadosEndereco = {
      'id': id,
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cidade': cidade?.toJson(),
    };

    return dadosEndereco;
  }
}
