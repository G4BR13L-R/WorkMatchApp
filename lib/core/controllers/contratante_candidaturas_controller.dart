import 'package:work_match_app/core/models/candidatura_model.dart';
import 'package:work_match_app/core/services/candidaturas_service.dart';

class ContratanteCandidaturasController {
  final CandidaturasService _candidaturasService = CandidaturasService();

  Future<List<CandidaturaModel>> index(int id) {
    return _candidaturasService.index(id);
  }

  Future<CandidaturaModel> show(int id) {
    return _candidaturasService.show(id);
  }

  Future<CandidaturaModel> register(int ofertaId, double salario) {
    return _candidaturasService.store(ofertaId, salario);
  }

  Future<bool> update(int id, int ofertaID, double salario) {
    return _candidaturasService.update(id, ofertaID, salario);
  }

  Future<bool> destroy(int id) {
    return _candidaturasService.destroy(id);
  }

  Future<bool> changeStatus(int candidaturaId, int status) {
    return _candidaturasService.changeStatus(candidaturaId, status);
  }
}
