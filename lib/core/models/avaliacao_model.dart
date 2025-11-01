import 'package:work_match_app/core/models/oferta_model.dart';

class AvaliacaoModel {
  final int? id;
  final int autor_id;
  final String autor_tipo;
  final String autor_nome;
  final int destinatario_id;
  final String destinatario_tipo;
  final String destinatario_nome;
  final OfertaModel oferta;
  final int nota;
  final String? comentario;

  AvaliacaoModel({
    this.id,
    required this.autor_id,
    required this.autor_tipo,
    required this.autor_nome,
    required this.destinatario_id,
    required this.destinatario_tipo,
    required this.destinatario_nome,
    required this.oferta,
    required this.nota,
    this.comentario,
  });

  factory AvaliacaoModel.fromJson(Map<String, dynamic> json) {
    return AvaliacaoModel(
      id: json['id'],
      autor_id: json['autor_id'],
      autor_tipo: json['autor_tipo'],
      autor_nome: json['autor_nome'],
      destinatario_id: json['destinatario_id'],
      destinatario_tipo: json['destinatario_tipo'],
      destinatario_nome: json['destinatario_nome'],
      oferta: OfertaModel.fromJson(json['oferta']),
      nota: json['nota'],
      comentario: json['comentario'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> dadosAvaliacao = {
      'id': id,
      'autor_id': autor_id,
      'autor_tipo': autor_tipo,
      'autor_nome': autor_nome,
      'destinatario_id': destinatario_id,
      'destinatario_tipo': destinatario_tipo,
      'destinatario_nome': destinatario_nome,
      'oferta': oferta.toJson(),
      'nota': nota,
      'comentario': comentario,
    };

    return dadosAvaliacao;
  }
}
