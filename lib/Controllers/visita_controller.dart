import 'package:emel/models/visita.dart';
import 'package:emel/service/visita_service.dart';

class VisitaController {
  VisitaService visitaService = VisitaService();

  Future<void> cadastrarVisita(
    String cpfVisitante, // <-- Mudou aqui: recebe o CPF da tela
    DateTime dataHoraEntrada,
    DateTime? dataHoraSaida,
    String? observacao,
    String tipo,
    int idMorador,
  ) async {
    
    // O Controller monta o objeto Visita perfeitamente
    Visita visita = Visita(
      null,
      dataHoraEntrada,
      dataHoraSaida,
      observacao,
      tipo,
      idMorador,
    );

    // E manda a Visita + CPF pro Service aplicar a regra de negócio
    await visitaService.registrarNovaVisita(visita, cpfVisitante);
  }

  Future<int> buscarQtdeVisitas(int idMorador)async{
    int qtdeVisitas = await visitaService.buscarQtdeVisitas(idMorador);
    return qtdeVisitas;
  }

  Future<int> buscarQtdeVisitantes(int idMorador)async{
    int qtdeVisitantes = await visitaService.buscarQtdeVisitantes(idMorador);
    return qtdeVisitantes;
  }

  Future<int> buscarQtdePrestadoresServico(int idMorador)async{
    int qtdePrestadores = await visitaService.buscarqtdePrestadoresServico(idMorador);
    return qtdePrestadores;
  }

   Future<List<dynamic>> buscarVisitasAgendadas(int idVisitante) async{
    List<dynamic> visitasAgendadas = await visitaService.buscarVisitasAgendadas(idVisitante);
    return visitasAgendadas;
  }
  Future<void> deletarVisitaPorId(int idVisita, bool canceladoPorVisitante) async {
    await visitaService.deletarVisita(idVisita, canceladoPorVisitante);
  }
  Future<void> editarDataHora(DateTime novaDataHora, int idVisita) async{
    await visitaService.editarDataHora(idVisita, novaDataHora);
  }
  Future<List<dynamic>> buscarHistoricoVisitas(int idMorador) async{
    final response = await visitaService.buscarHistoricoVisitas(idMorador);
    return response;
  }

  Future<Map<String, dynamic>?> buscarVisitaProximaHora(int idVisitante) async {
    return await visitaService.buscarVisitaProximaHora(idVisitante);
  }

  Future<void> registrarChegada(int idVisita, int idVisitante) async {
    await visitaService.registrarChegada(idVisita, idVisitante);
  }

  Future<bool> validarCodigoEntrada(
    int idVisita,
    int idVisitante,
    String codigoDigitado,
  ) async {
    return await visitaService.validarCodigoEntrada(
      idVisita,
      idVisitante,
      codigoDigitado,
    );
  }

  Future<Map<String, dynamic>?> registrarEntrada(
    int idVisita,
    int idVisitante,
  ) async {
    return await visitaService.registrarEntrada(idVisita, idVisitante);
  }

  Future<Map<String, dynamic>?> encerrarVisitaPorExpiracao(
    int idVisita,
    int idVisitante,
  ) async {
    return await visitaService.encerrarVisitaPorExpiracao(
      idVisita,
      idVisitante,
    );
  }

  Future<Map<String, dynamic>?> buscarDadosAtendimentoPorIdVisita(
    int idVisita,
  ) async {
    return await visitaService.buscarDadosAtendimentoPorIdVisita(idVisita);
  }
}
