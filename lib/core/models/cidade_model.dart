import 'package:work_match_app/core/models/estado_model.dart';

class CidadeModel {
  final int? id;
  final String descricao;
  final EstadoModel? estado;

  CidadeModel({this.id, required this.descricao, required this.estado});

  factory CidadeModel.fromJson(Map<String, dynamic> json) {
    return CidadeModel(
      id: json['id'],
      descricao: json['descricao'],
      estado: json['estado'] != null ? EstadoModel.fromJson(json['estado']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'descricao': descricao, 'estado': estado?.toJson()};
  }
}
