import 'package:emel/models/visitante.dart';
import 'package:emel/repository/visitante_repository.dart';

class VisitanteService {

  VisitanteRepository visitanteRepository = VisitanteRepository();

  Future<Visitante?> validarLoginVisitante(String cpfLogin, String senhaLogin)async {
    Visitante? visitante = await visitanteRepository.loginVisitante(cpfLogin, senhaLogin);
    return visitante;
  }

  Future<void> cadastrarVisitante(Visitante visitante) async{
    await visitanteRepository.cadastrarVisitante(visitante);
  }

  Future<List<Visitante>> listarVisitantes() async {
    return await visitanteRepository.listarVisitantes();
  }
  
}