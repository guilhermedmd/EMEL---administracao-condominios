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

}