import 'package:emel/core/supabase/supabase_config.dart';
import 'package:emel/models/visitante.dart';
import 'package:emel/sessionRepository/usuario_session.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class VisitanteRepository {
  final supabase = SupabaseConfig.client;
  Future<Visitante?> loginVisitante(String cpfLogin, String senhaLogin) async {
    var response = await supabase
        .from("visitante")
        .select("id_visitante, nome, cpf, email, senha")
        .eq("cpf", cpfLogin)
        .eq("senha", senhaLogin)
        .maybeSingle();
    if (response == null) {
      return null;
    }
    Visitante visitante = Visitante.fromJson(response);
    UsuarioSession().salvarVisitante(response);
    return visitante;
  }

  Future<void> cadastrarVisitante(Visitante visitante) async {
    await supabase.from("visitante").insert(visitante.toJson());
  }

  Future<List<Visitante>> listarVisitantes() async {
    final response = await supabase
        .from("visitante")
        .select("id_visitante, nome, cpf, email, senha");

    return response.map<Visitante>((json) => Visitante.fromJson(json)).toList();
  }

  Future<int> contarVisitantes() async {
  final response = await supabase
      .from("visitante")
      .select("id_visitante") // Remova o FetchOptions daqui
      .count(CountOption.exact); // Aplique a contagem aqui

  return (response.count ?? 0); 
}

Future<Visitante?> buscarPorCpf(String cpfBusca) async {
    var response = await supabase
        .from("visitante")
        .select("*")
        .eq("cpf", cpfBusca)
        .maybeSingle();

    if (response == null) {
      return null; // Visitante não existe no banco
    }
    return Visitante.fromJson(response); // Retorna o visitante com o ID preenchido
  }

  Future<void> registrarTokenDispositivo(int idVisitante) async {
  // 1. Pede ao OneSignal o ID único deste aparelho
  final idDispositivo = OneSignal.User.pushSubscription.id;

  // Se por algum motivo o celular ainda não gerou o ID, a gente aborta para não dar erro
  if (idDispositivo == null || idDispositivo.isEmpty) {
    print("Celular ainda não possui Token do OneSignal.");
    return;
  }

  // 2. Salva no banco de dados usando o UPSERT (Insere se for novo, atualiza se já existir)
  try {
    await supabase.from('token_notificacao').upsert({
      'token': idDispositivo,
      'id_visitante_fk': idVisitante
    }, onConflict: 'id_visitante_fk'); // A mágica da relação 1:1 entra aqui!
    
    print("Token do dispositivo salvo com sucesso!");
  } catch (e) {
    print("Erro ao salvar o token: $e");
  }
}
}
