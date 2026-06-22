import 'package:emel/models/visita.dart';
import 'package:emel/repository/visita_repository.dart';

class VisitaService {
  VisitaRepository visitaRepository = VisitaRepository();

  Future<void> cadastrarVisita(Visita visita, int idVisitante) async {
    await visitaRepository.cadastrarVisita(visita, idVisitante);
  }

  Future<int> buscarQtdeVisitas(int idMorador)async{
    int qtdeVisitas = await visitaRepository.buscarQtdeVisitas(idMorador);
    return qtdeVisitas;
  }

  Future<int> buscarQtdeVisitantes(int idMorador)async{
    int qtdeVisitantes = await visitaRepository.buscarQtdeVisitantes(idMorador);
    return qtdeVisitantes;
  }

  Future<int> buscarqtdePrestadoresServico(int idMorador)async{
    int qtdePrestadores = await visitaRepository.buscarQtdPrestadoresPorMorador(idMorador);
    return qtdePrestadores;
  }
  Future<List<dynamic>> buscarVisitasAgendadas(int idVisitante) async{
    List<dynamic> visitasAgendadas = await visitaRepository.buscarHistoricoVisitante(idVisitante);
    return visitasAgendadas;
  }
  
}
