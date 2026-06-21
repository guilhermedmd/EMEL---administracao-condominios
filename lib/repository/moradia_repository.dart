import 'package:emel/core/supabase/supabase_config.dart';
import 'package:emel/sessionRepository/moradia_session.dart';

class MoradiaRepository {
  final supabase = SupabaseConfig.client;

  Future<void> getMoradiaInfo(IdMoradoria) async{
    final resp = await supabase.from("moradia").select("id_moradia, bloco, numero").eq("id_moradia", IdMoradoria).maybeSingle();
    if(resp == null){
      throw Exception("Moradia não encontrada");
    }
    MoradiaSession().salvarMoradia(resp);
  }
  
}