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

  // Adicione em VisitaRepository ou em um novo repositório
  // Para Estatísticas Gerais
  Future<Map<String, int>> buscarEstatisticasGerais() async {
    // Executamos o count dentro de um select para garantir compatibilidade
    final totalVisitas = await supabase.from("visita").count(CountOption.exact);
    final totalVisitantes = await supabase
        .from("visitante")
        .count(CountOption.exact);

    return {
      "totalVisitas":
          totalVisitas, // Remova o .count se ele retornar o valor direto
      "totalVisitantes": totalVisitantes,
    };
  }

  // Para Prestadores de Serviço
  Future<int> buscarQtdPrestadoresPorMorador(int idMorador) async {
    final response = await supabase
        .from("visita")
        .select("id_visitante") // Seleciona apenas o campo que quer contar
        .eq("id_morador", idMorador)
        .eq("tipo_visitante", "prestador_servico")
        .count(CountOption.exact); // Aplica a contagem na query já filtrada

    return response.count ?? 0;
  }

  Future<List<Map<String, dynamic>>> listarHistoricoLiberacoes() async {
  // O Supabase precisa entender o caminho: visita -> participantes_visita -> visitante
  final response = await supabase
    .from('visita')
    .select('*') // Busca só os dados da tabela visita, sem tentar relacionar com visitante
    .order('data_hora_entrada', ascending: false);

  return List<Map<String, dynamic>>.from(response);
}
}
