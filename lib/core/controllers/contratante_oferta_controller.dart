import 'package:work_match_app/core/models/oferta_model.dart';
import 'package:work_match_app/core/services/oferta_service.dart';

class ContratanteOfertaController {
  final OfertaService ofertaRepository = OfertaService();

  Future<List<OfertaModel>> index() {
    return ofertaRepository.index();
  }

  Future<OfertaModel> register(
    String titulo,
    String descricao,
    double salario,
    String dataInicio,
    String dataFim,
    String logradouro,
    String numero,
    String complemento,
    String bairro,
    int cidadeID,
  ) {
    if (titulo.isEmpty) throw Exception("O campo titulo é obrigatório");
    if (descricao.isEmpty) throw Exception("o campo descrição é obrigatório");
    if (dataInicio.isEmpty) throw Exception("o campo data de início é obrigatório");
    if (dataInicio.length < 10) throw Exception("o campo data de início é inválido");
    if (dataFim.isEmpty) throw Exception("o campo data de fim é obrigatório");
    if (dataFim.length < 10) throw Exception("o campo data de fim é inválido");
    if (logradouro.isEmpty) throw Exception("o campo logradouro é obrigatório");
    if (numero.isEmpty) throw Exception("o campo número é obrigatório");
    if (bairro.isEmpty) throw Exception("o campo bairro é obrigatório");

    dataInicio = dataInicio.split('/').reversed.join('-');
    dataFim = dataFim.split('/').reversed.join('-');

    return ofertaRepository.store(
      titulo,
      descricao,
      salario,
      dataInicio,
      dataFim,
      logradouro,
      numero,
      complemento,
      bairro,
      cidadeID,
    );
  }

  Future<bool> update(
    int id,
    String titulo,
    String descricao,
    double salario,
    String dataInicio,
    String dataFim,
    String logradouro,
    String numero,
    String complemento,
    String bairro,
    int cidadeID,
  ) {
    if (titulo.isEmpty) throw Exception("O campo titulo é obrigatório");
    if (descricao.isEmpty) throw Exception("o campo descrição é obrigatório");
    if (dataInicio.isEmpty) throw Exception("o campo data de início é obrigatório");
    if (dataInicio.length < 10) throw Exception("o campo data de início é inválido");
    if (dataFim.isEmpty) throw Exception("o campo data de fim é obrigatório");
    if (dataFim.length < 10) throw Exception("o campo data de fim é inválido");
    if (logradouro.isEmpty) throw Exception("o campo logradouro é obrigatório");
    if (numero.isEmpty) throw Exception("o campo número é obrigatório");
    if (bairro.isEmpty) throw Exception("o campo bairro é obrigatório");

    dataInicio = dataInicio.split('/').reversed.join('-');
    dataFim = dataFim.split('/').reversed.join('-');

    return ofertaRepository.update(
      id,
      titulo,
      descricao,
      salario,
      dataInicio,
      dataFim,
      logradouro,
      numero,
      complemento,
      bairro,
      cidadeID,
    );
  }

  Future<bool> destroy(int id) {
    return ofertaRepository.destroy(id);
  }
}
