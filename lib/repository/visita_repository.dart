import 'package:emel/core/supabase/supabase_config.dart';
import 'package:emel/models/visita.dart';
import 'package:emel/sessionRepository/usuario_session.dart';
import 'package:emel/utils/formator_datas.dart';
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

  Future<List<dynamic>> buscarHistoricoVisitante(int idVisitante) async {
    final response = await supabase
        .from('participantes_visita')
        .select('''
        visita(
          id_visita,
          observacao,
          data_hora_entrada,
          data_hora_saida,
          tipo,
          morador(
            nome,
            condominio(
              Token_Acesso
            )
          )
        )
      ''')
        .eq('id_visitante_fk', idVisitante);

    return response;
  }

  Future<void> enviarNotificacao(
    String tokenDispositivo, {
    String titulo = "Visita Agendada!",
    String mensagem = "Sua entrada foi autorizada na portaria.",
  }) async {
    String appId = "9298e82d-e2ee-4a5c-a6ed-19e24d5256da";
    final rawKey = (dotenv.env['ONESIGNAL_REST_API_KEY'] ?? '').trim();
    final authHeader =
        rawKey.startsWith('Basic ') || rawKey.startsWith('Key ')
            ? rawKey
            : 'Basic $rawKey';

    var url = Uri.parse('https://onesignal.com/api/v1/notifications');

    var corpo = jsonEncode({
      "app_id": appId,
      // Aqui passamos o "CEP" do celular que pegamos do Supabase:
      "include_subscription_ids": [tokenDispositivo],
      "priority": 10,
      "headings": {"en": titulo, "pt": titulo},
      "contents": {"en": mensagem, "pt": mensagem}
    });

    try {
      var resposta = await http.post(
        url,
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": authHeader
        },
        body: corpo,
      );

      if (resposta.statusCode == 200) {
        print("Notificação enviada com sucesso: ${resposta.body}");
      } else {
        print("Erro ao enviar notificação (${resposta.statusCode}): ${resposta.body}");
      }
    } catch (e) {
      print("Erro no código ao enviar notificação: $e");
    }
  }
  // método para editar horário e data da visita
  Future<void> editarHoraData(DateTime novaDataHora, int idVisita) async{
    print("repository");
    try{
      await supabase.from('visita')
        .update({
          'data_hora_entrada': novaDataHora.toIso8601String(),
        })
        .eq('id_visita', idVisita);
        print('Horário de visita editado com sucesso!');
    }catch (e){
      print("Erro ao editar horário de visita: $e");
    }
  }

  Future<void> deletarVisitaPorId(
    int idVisita, bool canceladoPorVisitante) async {
    try {
      final dadosVisita = await supabase
          .from('visita')
          .select('''
            id_morador_fk,
            data_hora_entrada,
            morador(
              nome
            ),
            participantes_visita(
              id_visitante_fk,
              visitante(
                nome
              )
            )
          ''')
          .eq('id_visita', idVisita)
          .maybeSingle();

      final String dataFormatada = FormatadorDatas()
          .formatarData(dadosVisita?['data_hora_entrada']?.toString());
      const String titulo = 'Visita Cancelada';

      if (canceladoPorVisitante) {
        final int? idMorador = dadosVisita?['id_morador_fk'];

        if (idMorador != null) {
          String nomeVisitante = UsuarioSession().nomeUsuario;
          final participantes = dadosVisita?['participantes_visita'];
          if (participantes is List &&
              participantes.isNotEmpty &&
              participantes[0]['visitante'] != null &&
              participantes[0]['visitante']['nome'] != null) {
            nomeVisitante = participantes[0]['visitante']['nome'].toString();
          }
          if (nomeVisitante.trim().isEmpty) {
            nomeVisitante = 'O visitante';
          }

          final String mensagem = dataFormatada.isNotEmpty
              ? '$nomeVisitante cancelou a visita agendada para $dataFormatada.'
              : '$nomeVisitante cancelou a visita agendada.';

          // 1. Registra o cancelamento na tabela de notificações do morador
          try {
            await supabase.from('notificacao').insert({
              'titulo': titulo,
              'descricao': mensagem,
              'lida': false,
              'data_horario': DateTime.now().toIso8601String(),
              'tipo': 'Visita',
              'id_morador_fk': idMorador,
            });
            print('Notificação de cancelamento salva no banco!');
          } catch (e) {
            print('Erro ao salvar notificação no banco: $e');
          }

          // 2. Busca o token do morador e envia push pelo OneSignal
          try {
            final respostaToken = await supabase
                .from('token_notificacao')
                .select('token')
                .eq('id_morador_fk', idMorador)
                .maybeSingle();

            if (respostaToken != null && respostaToken['token'] != null) {
              final String tokenMorador = respostaToken['token'].toString();
              await enviarNotificacao(
                tokenMorador,
                titulo: titulo,
                mensagem: mensagem,
              );
            } else {
              print(
                'Aviso: Morador $idMorador não possui token registrado para receber push.',
              );
            }
          } catch (e) {
            print('Erro ao enviar push de cancelamento para o morador: $e');
          }
        }
      } else {
        // Morador cancelou -> notifica o(s) visitante(s) via push
        String nomeMorador = dadosVisita?['morador']?['nome']?.toString() ??
            UsuarioSession().nomeUsuario;
        if (nomeMorador.trim().isEmpty) {
          nomeMorador = 'O morador';
        }

        final String mensagem = dataFormatada.isNotEmpty
            ? '$nomeMorador cancelou a visita agendada para $dataFormatada.'
            : '$nomeMorador cancelou a visita agendada.';

        final participantes = dadosVisita?['participantes_visita'];
        if (participantes is List) {
          for (final participante in participantes) {
            final int? idVisitante = participante['id_visitante_fk'];
            if (idVisitante == null) continue;

            try {
              final respostaToken = await supabase
                  .from('token_notificacao')
                  .select('token')
                  .eq('id_visitante_fk', idVisitante)
                  .maybeSingle();

              if (respostaToken != null && respostaToken['token'] != null) {
                final String tokenVisitante = respostaToken['token'].toString();
                await enviarNotificacao(
                  tokenVisitante,
                  titulo: titulo,
                  mensagem: mensagem,
                );
              } else {
                print(
                  'Aviso: Visitante $idVisitante não possui token registrado para receber push.',
                );
              }
            } catch (e) {
              print('Erro ao enviar push de cancelamento para o visitante: $e');
            }
          }
        }
      }

      await supabase
          .from('visita')
          .delete()
          .eq('id_visita', idVisita);

      print('Visita deletada com sucesso!');
    } catch (e) {
      print('Erro ao deletar visita: $e');
    }
  }

  Future<List<dynamic>> buscarHistoricoVistas(int idMorador) async{
   final response = await supabase
          .from('visita')
          .select('''
      id_visita,
      data_hora_entrada,
      data_hora_saida,
      tipo,
      observacao,
      participantes_visita(
        visitante(
          nome
        )
      )
    ''')
          .eq('id_morador_fk', idMorador);
    return response;
  }
}
