class StatusModel {
  int id;
  String descricao;

  StatusModel({required this.id, required this.descricao});

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(id: json['id'], descricao: json['descricao']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'descricao': descricao};
  }
}
