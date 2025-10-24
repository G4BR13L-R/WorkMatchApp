import 'package:work_match_app/core/models/candidatura_model.dart';
import 'package:work_match_app/core/services/contratante/candidatura_service.dart';

class CandidaturaController {
  final CandidaturaService _candidaturaService = CandidaturaService();

  Future<List<CandidaturaModel>> index(int ofertaId) {
    return _candidaturaService.index(ofertaId);
  }

  Future<CandidaturaModel> show(int id) {
    return _candidaturaService.show(id);
  }

  Future<bool> changeStatus(int candidaturaId, int status) {
    return _candidaturaService.changeStatus(candidaturaId, status);
  }
}
