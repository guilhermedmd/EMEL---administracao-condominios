import 'package:emel/models/visitante.dart';
import 'package:emel/service/visitante_service.dart';

class VisitanteController {
  VisitanteService visitanteService = VisitanteService();

  Future<bool> login(String cpfLogin, String senha)async{
    Visitante? visitante = await visitanteService.validarLoginVisitante(cpfLogin, senha);
    if(visitante != null){
      return true;
    }
    return false;
  }

  Future<void> cadastrarVisitante(String nome, String cpf, String email, String senha, DateTime dataNasc) async{
    Visitante visitante = Visitante.banco(nome, cpf, email, senha, dataNasc);
    await visitanteService.cadastrarVisitante(visitante);
  }

  Future<List<Visitante>> listarVisitantes() async {
    return await visitanteService.listarVisitantes();
  }
  
}