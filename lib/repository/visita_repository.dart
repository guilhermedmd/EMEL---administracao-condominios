import 'package:emel/core/supabase/supabase_config.dart';
import 'package:emel/models/visita.dart';

class VisitaRepository {

  final supabase = SupabaseConfig.client;
  Future<void> cadastrarVisita(
      Visita visita,
      int idVisitante
  ) async {

    final response = await supabase.from("visita").insert(visita.toJson()).select("id_visita").single();
    await supabase.from("participantes_visita").insert({
          "id_visita_fk": response["id_visita"],
          "id_visitante_fk": idVisitante
        });
  }
}