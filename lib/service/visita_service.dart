import 'package:emel/models/visita.dart';
import 'package:emel/repository/visita_repository.dart';
import 'package:emel/repository/visitante_repository.dart';

class VisitaService {
  final VisitaRepository visitaRepository = VisitaRepository();
  final VisitanteRepository visitanteRepository = VisitanteRepository(); 

  Future<void> registrarNovaVisita(Visita visita, String cpfVisitante) async {
    
    // 1. Limpa a máscara do CPF (tira pontos e traços)
    final cpfLimpo = cpfVisitante.replaceAll(RegExp(r'[^0-9]'), '');

    // 2. Busca o visitante pelo CPF
    final visitanteEncontrado = await visitanteRepository.buscarPorCpf(cpfLimpo);

    // 3. REGRA DE NEGÓCIO: Se não achar, joga o erro pra tela!
    if (visitanteEncontrado == null) {
      throw Exception("Visitante não encontrado! É necessário cadastrá-lo primeiro.");
    }

    // 4. Se passou, manda o repositório salvar usando o ID que o banco achou
    await visitaRepository.cadastrarVisita(visita, visitanteEncontrado.id_visitante!);
  }
}