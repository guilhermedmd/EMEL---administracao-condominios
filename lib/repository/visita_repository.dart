import 'package:emel/core/supabase/supabase_config.dart';
import 'package:emel/models/visita.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VisitaRepository {
  final supabase = SupabaseConfig.client;
  Future<void> cadastrarVisita(Visita visita, int idVisitante) async {
    final response = await supabase
        .from("visita")
        .insert(visita.toJson())
        .select("id_visita")
        .single();
    await supabase.from("participantes_visita").insert({
      "id_visita_fk": response["id_visita"],
      "id_visitante_fk": idVisitante,
    });
  }

  Future<int> buscarQtdeVisitas(int idMorador) async {
    print("Entrou em buscarQtdeVisitas");
    final responseVisitas = await supabase
    .from('visita')
    .select('id_visita')
    .eq('id_morador_fk', idMorador) 
    .count(CountOption.exact);
    print("visitas: ${responseVisitas.count}");

  final qtdeVisitas = responseVisitas.count;

    return qtdeVisitas;
  }

  Future<int> buscarQtdeVisitantes(int idMorador)async{
    final responseVisitantes = await supabase
    .from('participantes_visita')
    .select('id_visitante_fk, visita!inner(id_morador_fk)') 
    .eq('visita.id_morador_fk', idMorador) 
    .count(CountOption.exact);
    final qtdeVisitantes = responseVisitantes.count;

    return qtdeVisitantes;
  }

  Future<int> buscarQtdPrestadoresPorMorador(int idMorador) async {
    final responsePrestadores = await supabase
    .from('visita')
    .select('id_visita')
    .eq('tipo', 'Prestado de serviçosr')
    .eq('id_morador_fk', idMorador)
    .count(CountOption.exact);
  final qtdePrestadores = responsePrestadores.count;
    return qtdePrestadores;
  }

  // para visitante
  Future<List<dynamic>> buscarHistoricoVisitante(int idVisitante) async {
  final response = await supabase
      .from('participantes_visita')
      .select('''
        visita(
          observacao,
          data_hora_entrada,
          tipo,
          morador(
            nome
          )
        )
      ''')
      .eq('id_visitante_fk', idVisitante);

  return response;
}
}
