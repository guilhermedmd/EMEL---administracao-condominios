import 'package:emel/models/morador.dart';
import 'package:emel/repository/morador_repository.dart';
import 'package:emel/utils/formator_cpf.dart';

class MoradorService {
  MoradorRepository moradorRepository = MoradorRepository();

  Future<Morador?> validarLogin(String cpfLogin, String senhaLogin) async {
    String? cpfLimpo = FormatadorCpf().limparEValidarCpf(cpfLogin);
    Morador? morador = await moradorRepository.getMoradorPorLogin(
      cpfLimpo,
      senhaLogin,
    );

    return morador;
  }
}
