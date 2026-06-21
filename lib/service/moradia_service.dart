import 'package:emel/repository/moradia_repository.dart';

class MoradiaService {
  MoradiaRepository moradiaRepository = MoradiaRepository();

  Future<void> salvarMoradiaInfo(int idMoradia) async{
    await moradiaRepository.getMoradiaInfo(idMoradia);
  }
}