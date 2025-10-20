import 'package:work_match_app/core/models/contratado_model.dart';
import 'package:work_match_app/core/models/oferta_model.dart';
import 'package:work_match_app/core/models/status_model.dart';

class CandidaturaModel {
  final int? id;
  final ContratadoModel contratado;
  final OfertaModel oferta;
  final StatusModel status;
  final double salario;

  CandidaturaModel({
    this.id,
    required this.contratado,
    required this.oferta,
    required this.status,
    required this.salario,
  });

  factory CandidaturaModel.fromJson(Map<String, dynamic> json) {
    return CandidaturaModel(
      id: json['id'],
      contratado: ContratadoModel.fromJson(json['contratado']),
      oferta: OfertaModel.fromJson(json['oferta']),
      status: StatusModel.fromJson(json['status']),
      salario: double.parse(json['salario'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> dadosCandidatura = {
      'id': id,
      'contratado': contratado.toJson(),
      'oferta': oferta.toJson(),
      'status': status.toJson(),
      'salario': salario,
    };

    return dadosCandidatura;
  }
}
