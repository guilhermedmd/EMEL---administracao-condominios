import 'package:emel/service/moradia_service.dart';

class MoradiaController {
  MoradiaService moradiaService = MoradiaService();

  Future<void> salvarMoradiaInfo(int idMoradia)async{
    await moradiaService.salvarMoradiaInfo(idMoradia);
  }
}