import 'package:work_match_app/core/models/endereco_model.dart';

class OfertaModel {
  final int? id;
  final String titulo;
  final String descricao;
  final double salario;
  final String dataInicio;
  final String dataFim;
  final bool finalizada;
  final EnderecoModel endereco;

  OfertaModel({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.salario,
    required this.dataInicio,
    required this.dataFim,
    required this.finalizada,
    required this.endereco,
  });

  factory OfertaModel.fromJson(Map<String, dynamic> json) {
    return OfertaModel(
      id: json['id'],
      titulo: json['titulo'],
      descricao: json['descricao'],
      salario: double.parse(json['salario'].toString()),
      dataInicio: json['data_inicio'],
      dataFim: json['data_fim'],
      finalizada: json['finalizada'],
      endereco: EnderecoModel.fromJson(json['endereco']),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> dadosOferta = {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'salario': salario,
      'data_inicio': dataInicio,
      'data_fim': dataFim,
      'finalizada': finalizada,
      'endereco': endereco.toJson(),
    };

    return dadosOferta;
  }
}
