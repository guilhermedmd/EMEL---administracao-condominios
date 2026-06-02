import 'package:emel/core/supabase/supabase_config.dart';
import 'package:emel/models/morador.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MoradorRepository extends ChangeNotifier{

  final supabase = SupabaseConfig.client;

  Future<List<dynamic>> getMorador() async{
    List<dynamic> moradores = await supabase.from("morador").select("nome");
    return moradores;
  }

  Future<Morador?> getMoradorPorLogin(String cpfLogin, String senhaLogin) async{
      final usuarioBox = Hive.box("usuario");
      final response = await supabase.from("morador").select("id_morador, nome, senha, cpf, email").eq("cpf", cpfLogin).eq("senha", senhaLogin).maybeSingle();
      if (response == null) {
      return null;
      }
     Morador morador = Morador.fromJson(response);
     usuarioBox.put("morador", response);
     notifyListeners();
     return morador;
  }

   String get nomeUsuario {
    final usuario =
        Hive.box("usuario").get("morador");

    if (usuario == null) {
      return "";
    }

    return usuario["nome"];
  }
}
