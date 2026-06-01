import 'package:emel/models/morador.dart';
import 'package:emel/repository/morador_repository.dart';

class MoradorService {
  MoradorRepository moradorRepository = MoradorRepository();

  Future<Morador?> validarLogin(String cpfLogin, String senhaLogin) async {
    Morador? morador = await moradorRepository.getMoradorPorLogin(
      cpfLogin,
      senhaLogin,
    );

    return morador;
  }
}
