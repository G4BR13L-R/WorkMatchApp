import 'package:work_match_app/core/models/candidatura_model.dart';
import 'package:work_match_app/core/models/oferta_model.dart';
import 'package:work_match_app/core/services/contratado/oferta_service.dart';

class OfertaController {
  final OfertaService _ofertaService = OfertaService();

  Future<List<OfertaModel>> index({bool? status, int? cidadeId}) {
    return _ofertaService.index(status: status, cidadeId: cidadeId);
  }

  Future<OfertaModel> show(int id) {
    return _ofertaService.show(id);
  }

  Future<CandidaturaModel> store(int ofertaId, double? salario) async {
    return _ofertaService.registerCandidatura(ofertaId, salario);
  }

  Future<bool> destroy(int id) async {
    return _ofertaService.deleteCandidatura(id);
  }
}
