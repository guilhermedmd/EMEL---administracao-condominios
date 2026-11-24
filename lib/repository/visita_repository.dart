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
    // 1. Salva a visita e o participante no banco
    final response = await supabase
        .from("visita")
        .insert(visita.toJson())
        .select("id_visita")
        .single();

    final idVisitaCriada = response["id_visita"];

    await supabase.from("participantes_visita").insert({
      "id_visita_fk": idVisitaCriada,
      "id_visitante_fk": idVisitante,
    });

    // 2. Disparo de notificação isolado (não falha o cadastro caso o push falhe)
    try {
      final respostaToken = await supabase
          .from('token_notificacao')
          .select('token')
          .eq('id_visitante_fk', idVisitante)
          .maybeSingle();

      if (respostaToken != null && respostaToken['token'] != null) {
        String tokenDoVisitante = respostaToken['token'].toString();
        await enviarNotificacao(tokenDoVisitante); 
      } else {
        print("Aviso: Esse visitante não possui token registrado para receber push.");
      }
    } catch (e) {
      print("Aviso ao enviar notificação: $e");
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
        data_chegada,
        data_entrada,
        tempo_atendimento,
        status_atendimento,
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
        data_chegada,
        data_entrada,
        tempo_atendimento,
        status_atendimento,
        visitante(
          nome
        )
      )
    ''')
          .eq('id_morador_fk', idMorador);
    return response;
  }

  // Busca visita agendada para os próximos 60 minutos ou com cronômetro em andamento
  Future<Map<String, dynamic>?> buscarVisitaProximaHora(int idVisitante) async {
    try {
      print('=== [buscarVisitaProximaHora] Iniciando busca para idVisitante: $idVisitante ===');
      if (idVisitante <= 0) {
        print('=== [buscarVisitaProximaHora] idVisitante inválido ($idVisitante) ===');
        return null;
      }

      final agora = DateTime.now();
      final response = await supabase
          .from('participantes_visita')
          .select('''
            id_visita_fk,
            id_visitante_fk,
            data_chegada,
            data_entrada,
            tempo_atendimento,
            status_atendimento,
            codigo_entrada,
            visita(
              id_visita,
              data_hora_entrada,
              data_hora_saida,
              observacao,
              tipo,
              morador(
                nome
              )
            )
          ''')
          .eq('id_visitante_fk', idVisitante);

      print('=== [buscarVisitaProximaHora] Registros retornados do banco: ${response.length} ===');
      if (response.isEmpty) return null;

      final List<dynamic> visitas = response;

      // 1. Prioridade: Visita com chegada registrada mas entrada ainda pendente (cronômetro em andamento)
      for (final item in visitas) {
        final dataChegada = item['data_chegada'];
        final dataEntrada = item['data_entrada'];
        if (dataChegada != null && dataEntrada == null) {
          print('=== [buscarVisitaProximaHora] Visita com cronômetro em andamento encontrada: id_visita ${item['id_visita_fk']} ===');
          return Map<String, dynamic>.from(item);
        }
      }

      // 2. Visita agendada para os próximos 60 minutos (tolerância de 30 min de atraso) e ainda sem entrada
      Map<String, dynamic>? visitaMaisProxima;
      int menorDiferenca = 999999;

      for (final item in visitas) {
        final dataEntrada = item['data_entrada'];
        if (dataEntrada != null) {
          continue; // Já finalizada
        }

        final rawVisita = item['visita'];
        if (rawVisita == null) continue;
        final Map<String, dynamic> dadosVisita = rawVisita is Map<String, dynamic>
            ? rawVisita
            : (rawVisita is List && rawVisita.isNotEmpty
                ? Map<String, dynamic>.from(rawVisita.first)
                : {});
        if (dadosVisita.isEmpty) continue;

        final dataHoraEntradaStr = dadosVisita['data_hora_entrada'];
        print('=== [buscarVisitaProximaHora] Analisando visita id ${dadosVisita['id_visita']} - data_hora_entrada: $dataHoraEntradaStr ===');

        if (dataHoraEntradaStr != null) {
          final parsed = DateTime.tryParse(dataHoraEntradaStr.toString());
          if (parsed != null) {
            // Diferença 1: Nominal (compara dia e horário nominal do relógio)
            final dataNominal = DateTime(
              parsed.year,
              parsed.month,
              parsed.day,
              parsed.hour,
              parsed.minute,
            );
            final diffNominal = dataNominal.difference(agora).inMinutes;

            // Diferença 2: UTC absoluto
            final diffUtc = parsed.toUtc().difference(agora.toUtc()).inMinutes;

            // Diferença 3: Local absoluto
            final diffLocal = parsed.toLocal().difference(agora).inMinutes;

            print('=== [buscarVisitaProximaHora] diffNominal: $diffNominal min | diffUtc: $diffUtc min | diffLocal: $diffLocal min | agora: $agora ===');

            int? diferencaMinutos;
            if (diffNominal >= -30 && diffNominal <= 60) {
              diferencaMinutos = diffNominal;
            } else if (diffUtc >= -30 && diffUtc <= 60) {
              diferencaMinutos = diffUtc;
            } else if (diffLocal >= -30 && diffLocal <= 60) {
              diferencaMinutos = diffLocal;
            }

            if (diferencaMinutos != null) {
              if (visitaMaisProxima == null || diferencaMinutos.abs() < menorDiferenca.abs()) {
                menorDiferenca = diferencaMinutos;
                visitaMaisProxima = Map<String, dynamic>.from(item);
              }
            }
          }
        }
      }

      if (visitaMaisProxima != null) {
        print('=== [buscarVisitaProximaHora] Visita selecionada: id ${visitaMaisProxima['id_visita_fk']} com diferença de $menorDiferenca min ===');
      } else {
        print('=== [buscarVisitaProximaHora] Nenhuma visita no intervalo [-30 min, +60 min] encontrada ===');
      }

      return visitaMaisProxima;
    } catch (e) {
      print('=== [buscarVisitaProximaHora] Erro ao buscar visita da próxima hora: $e ===');
      return null;
    }
  }

  // Registra o horário de chegada do visitante no banco (aciona Trigger 1 no Supabase)
  Future<void> registrarChegada(int idVisita, int idVisitante) async {
    try {
      await supabase
          .from('participantes_visita')
          .update({
            'data_chegada': DateTime.now().toUtc().toIso8601String(),
          })
          .eq('id_visita_fk', idVisita)
          .eq('id_visitante_fk', idVisitante);
    } catch (e) {
      print('Erro ao registrar chegada: $e');
      rethrow;
    }
  }

  // Valida se o código de 4 dígitos digitado confere com o gerado no banco pela trigger
  Future<bool> validarCodigoEntrada(
    int idVisita,
    int idVisitante,
    String codigoDigitado,
  ) async {
    try {
      final response = await supabase
          .from('participantes_visita')
          .select('codigo_entrada')
          .eq('id_visita_fk', idVisita)
          .eq('id_visitante_fk', idVisitante)
          .maybeSingle();

      if (response == null || response['codigo_entrada'] == null) {
        return false;
      }

      final codigoBanco = response['codigo_entrada'].toString().trim();
      final codigoDig = codigoDigitado.trim();
      return codigoBanco == codigoDig ||
          codigoBanco.padLeft(4, '0') == codigoDig.padLeft(4, '0');
    } catch (e) {
      print('Erro ao validar código de entrada: $e');
      return false;
    }
  }

  // Registra o horário de entrada do visitante no banco (aciona Trigger 2 no Supabase)
  Future<Map<String, dynamic>?> registrarEntrada(
    int idVisita,
    int idVisitante,
  ) async {
    try {
      final response = await supabase
          .from('participantes_visita')
          .update({
            'data_entrada': DateTime.now().toUtc().toIso8601String(),
          })
          .eq('id_visita_fk', idVisita)
          .eq('id_visitante_fk', idVisitante)
          .select('tempo_atendimento, status_atendimento, data_entrada')
          .maybeSingle();

      return response != null ? Map<String, dynamic>.from(response) : null;
    } catch (e) {
      print('Erro ao registrar entrada: $e');
      rethrow;
    }
  }

  // Encerra a visita por expiração automática (20 minutos decorridos sem confirmação de código)
  // Faz o update somente do horário de entrada (data_entrada), disparando a Trigger 2 no banco,
  // que calcula o tempo de atendimento e define o status como 'expirado'
  Future<Map<String, dynamic>?> encerrarVisitaPorExpiracao(
    int idVisita,
    int idVisitante,
  ) async {
    try {
      final response = await supabase
          .from('participantes_visita')
          .update({
            'data_entrada': DateTime.now().toUtc().toIso8601String(),
          })
          .eq('id_visita_fk', idVisita)
          .eq('id_visitante_fk', idVisitante)
          .select('tempo_atendimento, status_atendimento, data_entrada')
          .maybeSingle();

      return response != null ? Map<String, dynamic>.from(response) : null;
    } catch (e) {
      print('Erro ao encerrar visita por expiração: $e');
      rethrow;
    }
  }

  // Busca dados de atendimento de uma visita específica
  Future<Map<String, dynamic>?> buscarDadosAtendimentoPorIdVisita(
    int idVisita,
  ) async {
    try {
      final response = await supabase
          .from('participantes_visita')
          .select('tempo_atendimento, status_atendimento, data_chegada, data_entrada')
          .eq('id_visita_fk', idVisita)
          .maybeSingle();

      return response != null ? Map<String, dynamic>.from(response) : null;
    } catch (e) {
      print('Erro ao buscar dados de atendimento da visita: $e');
      return null;
    }
  }
}
