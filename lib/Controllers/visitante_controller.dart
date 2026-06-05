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
}