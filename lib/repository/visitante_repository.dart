import 'package:emel/core/supabase/supabase_config.dart';
import 'package:emel/models/visitante.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class VisitanteRepository{

final supabase = SupabaseConfig.client;

Future<Visitante> loginVisitante(String cpfLogin, String senhaLogin) async{
  var response = await supabase.from("visitante").select("id_visitante, nome, cpf, email, senha" ).eq("cpf", cpfLogin).eq("senha", senhaLogin).maybeSingle();
  if(response == null){
    throw Exception("ERRO: Visitante não encontrado");
  }
  Visitante visitante = Visitante.fromJson(response);
  return visitante;
}

}