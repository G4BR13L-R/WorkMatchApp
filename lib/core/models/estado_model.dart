class EstadoModel {
  final int? id;
  final String descricao;
  final String sigla;

  EstadoModel({this.id, required this.descricao, required this.sigla});

  factory EstadoModel.fromJson(Map<String, dynamic> json) {
    return EstadoModel(id: json['id'], descricao: json['descricao'], sigla: json['sigla']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'descricao': descricao, 'sigla': sigla};
  }
}
