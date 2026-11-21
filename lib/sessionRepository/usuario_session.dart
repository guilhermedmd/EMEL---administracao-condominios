import 'package:flutter/material.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:emel/repository/morador_repository.dart';
import 'package:emel/repository/visitante_repository.dart';

class UsuarioSession extends ChangeNotifier {
  static final UsuarioSession _instance = UsuarioSession._internal();
  factory UsuarioSession() => _instance;
  UsuarioSession._internal();

  final usuarioBox = Hive.box("usuario");
  

  Future<void> salvarMorador(PostgrestMap morador) async {
    await usuarioBox.put("user", morador);
    notifyListeners();

    try {
      MoradorRepository repository = MoradorRepository();
      int idMorador = (morador["id_morador"] as num?)?.toInt() ?? 0;
      if (idMorador > 0) {
        await repository.registrarTokenDispositivo(idMorador);
      }
    } catch (e) {
      print("Erro ao tentar registrar o token do morador no login: $e");
    }
  }

 Future<void> salvarVisitante(PostgrestMap visitante) async {
  // Salva o usuário na caixinha local
  await usuarioBox.put("user", visitante);
  notifyListeners();
  
  // 2. Chama a nossa função para salvar o token!
  try {
    VisitanteRepository repository = VisitanteRepository();
    // Pegamos o ID diretamente dos dados do banco que acabaram de chegar
    int idVisitante = (visitante["id_visitante"] as num?)?.toInt() ?? 0; 
    if (idVisitante > 0) {
      await repository.registrarTokenDispositivo(idVisitante);
    }
  } catch (e) {
    print("Erro ao tentar registrar o token no login: $e");
  }
}

  String get nomeUsuario {
    final usuario = usuarioBox.get("user");

    if (usuario == null) {
      return "";
    }

    return usuario["nome"]?.toString() ?? "";
  }

  bool get permissaoUsuario {
    final usuario = usuarioBox.get("user");
    if (usuario == null){
      return false;
    }
    return usuario["permissao"] == true;
  }

  int get idMorador {
    final usuario = usuarioBox.get("user");

    if (usuario == null) {
      return 0;
    }

    final val = usuario["id_morador"];
    if (val is int) return val;
    if (val is num) return val.toInt();
    if (val is String) return int.tryParse(val) ?? 0;
    return 0;
  }

  
  int get idVisitante {
    final usuario = usuarioBox.get("user");

    if (usuario == null) {
      return 0;
    }

    final val = usuario["id_visitante"];
    if (val is int) return val;
    if (val is num) return val.toInt();
    if (val is String) return int.tryParse(val) ?? 0;
    return 0;
  }

   int get idMoradorFk {
    final usuario = usuarioBox.get("user");

    if (usuario == null) {
      return 0;
    }

    final val = usuario["id_moradia_fk"];
    if (val is int) return val;
    if (val is num) return val.toInt();
    if (val is String) return int.tryParse(val) ?? 0;
    return 0;
  }


  Future<void> logoutUserSession() async {
    await usuarioBox.clear();
    notifyListeners();
  }

}
  // prováveis gets para o endereço, 
  //no caso a moradia do usuario deverão ser feitos