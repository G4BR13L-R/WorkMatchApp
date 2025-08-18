import 'package:work_match_app/data/models/estado_model.dart';

class CidadeModel {
  final int? id;
  final String descricao;
  final EstadoModel estado;

  CidadeModel({this.id, required this.descricao, required this.estado});

  factory CidadeModel.fromJson(Map<String, dynamic> json) {
    return CidadeModel(id: json['id'], descricao: json['descricao'], estado: EstadoModel.fromJson(json['estado']));
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'descricao': descricao, 'estado': estado.toJson()};
  }
}
