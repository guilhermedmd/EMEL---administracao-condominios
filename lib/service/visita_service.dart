import 'package:emel/models/visita.dart';
import 'package:emel/repository/visita_repository.dart';

class VisitaService {
  VisitaRepository visitaRepository = VisitaRepository();

  Future<void> cadastrarVisita(Visita visita, int idVisitante) async {
    await visitaRepository.cadastrarVisita(visita, idVisitante);
  }
}
