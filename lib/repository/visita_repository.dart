import 'package:emel/core/supabase/supabase_config.dart';
import 'package:emel/models/visita.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class VisitaRepository {
  final supabase = SupabaseConfig.client;

  Future<void> cadastrarVisita(Visita visita, int idVisitante) async {
    try {
      // 1. O SEU CÓDIGO INTACTO (Salva a visita e o participante)
      final response = await supabase
          .from("visita")
          .insert(visita.toJson())
          .select("id_visita")
          .single();

      await supabase.from("participantes_visita").insert({
        "id_visita_fk": response["id_visita"],
        "id_visitante_fk": idVisitante,
      });

      // 2. A MÁGICA DA NOTIFICAÇÃO ENTRA AQUI
      // Busca o token "CEP" do visitante no banco
      final respostaToken = await supabase
          .from('token_notificacao')
          .select('token')
          .eq('id_visitante_fk', idVisitante)
          .maybeSingle();

      // Se achou o token, dispara o foguete!
      if (respostaToken != null) {
        String tokenDoVisitante = respostaToken['token'];
        await enviarNotificacao(tokenDoVisitante); 
      } else {
        print("Aviso: Esse visitante não possui token registrado para receber push.");
      }

    } catch (e) {
      print("Erro ao cadastrar visita ou enviar notificação: $e");
    }
  }

  Future<int> buscarQtdeVisitas(int idMorador) async {
    print("Entrou em buscarQtdeVisitas");
    final responseVisitas = await supabase
        .from('visita')
        .select('id_visita')
        .eq('id_morador_fk', idMorador)
        .count(CountOption.exact);
    print("visitas: ${responseVisitas.count}");

    final qtdeVisitas = responseVisitas.count;

    return qtdeVisitas;
  }

  Future<int> buscarQtdeVisitantes(int idMorador) async {
    final responseVisitantes = await supabase
        .from('participantes_visita')
        .select('id_visitante_fk, visita!inner(id_morador_fk)')
        .eq('visita.id_morador_fk', idMorador)
        .count(CountOption.exact);
    final qtdeVisitantes = responseVisitantes.count;

    return qtdeVisitantes;
  }

  Future<int> buscarQtdPrestadoresPorMorador(int idMorador) async {
    final responsePrestadores = await supabase
        .from('visita')
        .select('id_visita')
        .eq('tipo', 'Prestado de serviçosr')
        .eq('id_morador_fk', idMorador)
        .count(CountOption.exact);
    final qtdePrestadores = responsePrestadores.count;
    return qtdePrestadores;
  }

  // para visitante
  Future<List<dynamic>> buscarHistoricoVisitante(int idVisitante) async {
    final response = await supabase
        .from('participantes_visita')
        .select('''
        visita(
          observacao,
          data_hora_entrada,
          tipo,
          morador(
            nome
          )
        )
      ''')
        .eq('id_visitante_fk', idVisitante);
    print(response);

    return response;
  }

Future<void> enviarNotificacao(String tokenVisitante) async {
  
  String appId = "9298e82d-e2ee-4a5c-a6ed-19e24d5256da"; 
  String restApiKey = "Basic ${dotenv.env['ONESIGNAL_REST_API_KEY']}";  // colocar aqui a chave.

  var url = Uri.parse('https://onesignal.com/api/v1/notifications');

  var corpo = jsonEncode({
    "app_id": appId,
    // Aqui passamos o "CEP" do celular que pegamos do Supabase:
    "include_subscription_ids": [tokenVisitante], 
    "headings": {"en": "Visita agendada", "pt": "Visita Agendada!"},
    "contents": {"en": "Sua entrada foi autorizada na portaria.", "pt": "Sua entrada foi autorizada na portaria."}
  });

  try {
    var resposta = await http.post(
      url,
      headers: {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": "Basic $restApiKey"
      },
      body: corpo,
    );

    if (resposta.statusCode == 200) {
      print(" Notificação enviada");
    } else {
      print(" Erro ao enviar: ${resposta.body}");
    }
  } catch (e) {
    print("Erro no código: $e");
  }
}
}
