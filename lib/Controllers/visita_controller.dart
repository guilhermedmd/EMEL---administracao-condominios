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
}
