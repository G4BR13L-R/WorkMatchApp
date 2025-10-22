import 'package:work_match_app/core/models/candidatura_model.dart';
import 'package:work_match_app/core/services/contratante/candidatura_service.dart';

class CandidaturaController {
  final CandidaturaService _candidaturaService = CandidaturaService();

  Future<List<CandidaturaModel>> index(int id) {
    return _candidaturaService.index(id);
  }

  Future<CandidaturaModel> show(int id) {
    return _candidaturaService.show(id);
  }

  Future<CandidaturaModel> register(int ofertaId, double salario) {
    return _candidaturaService.store(ofertaId, salario);
  }

  Future<bool> update(int id, int ofertaID, double salario) {
    return _candidaturaService.update(id, ofertaID, salario);
  }

  Future<bool> destroy(int id) {
    return _candidaturaService.destroy(id);
  }

  Future<bool> changeStatus(int candidaturaId, int status) {
    return _candidaturaService.changeStatus(candidaturaId, status);
  }
}
