import 'package:emel/core/supabase/supabase_config.dart';
import 'package:emel/models/notificacao.dart';
import 'package:emel/sessionRepository/notificacao_session.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificacaoRepository {
  final supabase = SupabaseConfig.client;

  Future<void> notificacoesRecentes(int idmorador)async{
    var notificacoes = await supabase.from("notificacao").select("titulo, descricao, lida, data_horario, tipo")
    .eq("id_morador_fk", idmorador)
    .order("data_horario", ascending: false).limit(4);
    
    if(notificacoes.isEmpty ){
      throw Exception("Notiifcações não encontradas");
    }
    NotificacaoSession().salvarNotificacoes(notificacoes);
    // for (var n in notificacoes){
    // n.forEach((chave, valor) {
    // print("$chave: $valor");
    // });
    // print(notificacoes);
    }


Future<List<Map<String, dynamic>>> getNotificacoes(int idmorador)async{
  // Pega todas as notificações ordenando da mais recente para a mais antiga, ou seja decrescente, 
  // pois ascending é false
  var notificacoes = await supabase.from("notificacao").select("titulo, descricao, lida, data_horario, tipo").eq("id_morador_fk", idmorador).order("data_horario", ascending: false);
  return notificacoes;
  }
}