import 'package:emel/core/supabase/supabase_config.dart';
import 'package:emel/models/visitante.dart';
import 'package:emel/sessionRepository/usuario_session.dart';

class VisitanteRepository{

final supabase = SupabaseConfig.client;
Future<Visitante?> loginVisitante(String cpfLogin, String senhaLogin) async{
  var response = await supabase.from("visitante").select("id_visitante, nome, cpf, email, senha" ).eq("cpf", cpfLogin).eq("senha", senhaLogin).maybeSingle();
  if(response == null){
    return null;
  }
  Visitante visitante = Visitante.fromJson(response);
  UsuarioSession().salvarVisitante(response);
  return visitante;
}

Future<void> cadastrarVisitante(Visitante visitante) async{
  await supabase.from("visitante").insert(visitante);
}

Future<List<Visitante>> listarVisitantes() async {
  final response = await supabase.from("visitante").select("id_visitante, nome, cpf, email, senha");

  return response
      .map<Visitante>((json) => Visitante.fromJson(json))
      .toList();
}

}