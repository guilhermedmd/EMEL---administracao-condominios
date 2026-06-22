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
}