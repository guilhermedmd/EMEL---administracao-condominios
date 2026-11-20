import 'package:emel/core/supabase/supabase_config.dart';
import 'package:emel/models/morador.dart';
import 'package:emel/sessionRepository/usuario_session.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class MoradorRepository{

  final supabase = SupabaseConfig.client;
  // código usado para teste, não vamos usar 
  // Future<List<dynamic>> getMorador() async{
  //   List<dynamic> moradores = await supabase.from("morador").select("nome");
  //   return moradores;
  // }

  Future<Morador?> getMoradorPorLogin(String? cpfLogin, String senhaLogin) async{
      final response = await supabase.from("morador").select("id_morador, nome, senha, cpf, email, permissao, id_moradia_fk").eq("cpf", cpfLogin ?? 0).eq("senha", senhaLogin).maybeSingle();
      if (response == null) {
      return null;
      }
     Morador morador = Morador.fromJson(response);
    //  salva o morador no hive e registra o token do OneSignal
     await UsuarioSession().salvarMorador(response);
     return morador;
  }

  Future<void> registrarTokenDispositivo(int idMorador) async {
    final idDispositivo = OneSignal.User.pushSubscription.id;

    if (idDispositivo == null || idDispositivo.isEmpty) {
      print("Celular ainda não possui Token do OneSignal.");
      return;
    }

    try {
      await supabase.from('token_notificacao').upsert({
        'token': idDispositivo,
        'id_morador_fk': idMorador,
      }, onConflict: 'id_morador_fk');

      print("Token do morador salvo com sucesso! (morador $idMorador)");
    } catch (e) {
      print("Erro ao salvar o token do morador: $e");
    }
  }

}
