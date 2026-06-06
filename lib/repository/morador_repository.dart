import 'package:emel/core/supabase/supabase_config.dart';
import 'package:emel/models/morador.dart';
import 'package:emel/sessionRepository/usuario_session.dart';

class MoradorRepository{

  final supabase = SupabaseConfig.client;
  // código usado para teste, não vamos usar 
  // Future<List<dynamic>> getMorador() async{
  //   List<dynamic> moradores = await supabase.from("morador").select("nome");
  //   return moradores;
  // }

  Future<Morador?> getMoradorPorLogin(String cpfLogin, String senhaLogin) async{
      final response = await supabase.from("morador").select("id_morador, nome, senha, cpf, email").eq("cpf", cpfLogin).eq("senha", senhaLogin).maybeSingle();
      if (response == null) {
      return null;
      }
     Morador morador = Morador.fromJson(response);
    //  salva o morador no hive
     UsuarioSession().salvarMorador(response);
     return morador;
  }

}
