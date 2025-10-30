import 'package:work_match_app/core/models/avaliacao_model.dart';
import 'package:work_match_app/core/models/contratado_model.dart';
import 'package:work_match_app/core/models/oferta_model.dart';
import 'package:work_match_app/core/models/status_model.dart';

class CandidaturaModel {
  final int? id;
  final ContratadoModel contratado;
  final OfertaModel oferta;
  final StatusModel status;
  final double salario;
  final List<AvaliacaoModel>? avaliacoes;

  CandidaturaModel({
    this.id,
    required this.contratado,
    required this.oferta,
    required this.status,
    required this.salario,
    this.avaliacoes,
  });

  factory CandidaturaModel.fromJson(Map<String, dynamic> json) {
    List<AvaliacaoModel> avaliacoes = [];

    if (json['avaliacoes'] != null) {
      avaliacoes = List<AvaliacaoModel>.from(json['avaliacoes'].map((x) => AvaliacaoModel.fromJson(x)));
    }

    return CandidaturaModel(
      id: json['id'],
      contratado: ContratadoModel.fromJson(json['contratado']),
      oferta: OfertaModel.fromJson(json['oferta']),
      status: StatusModel.fromJson(json['status']),
      salario: double.parse(json['salario'].toString()),
      avaliacoes: avaliacoes,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> dadosCandidatura = {
      'id': id,
      'contratado': contratado.toJson(),
      'oferta': oferta.toJson(),
      'status': status.toJson(),
      'salario': salario,
      'avaliacoes': avaliacoes?.map((x) => x.toJson()).toList(),
    };

    return dadosCandidatura;
  }
}
