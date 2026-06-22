import 'package:emel/models/visita.dart';
import 'package:emel/service/visita_service.dart';

class VisitaController {
  VisitaService visitaService = VisitaService();

  Future<void> cadastrarVisita(
    DateTime dataHoraEntrada,
    DateTime? dataHoraSaida,
    String? observacao,
    String tipo,
    int idMorador,
    int idVisitante,
  ) async {
    Visita visita = Visita(
      null,
      dataHoraEntrada,
      dataHoraSaida,
      observacao,
      tipo,
      idMorador,
    );

    await visitaService.cadastrarVisita(visita, idVisitante);
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
}
