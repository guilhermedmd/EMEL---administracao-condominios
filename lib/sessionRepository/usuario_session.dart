import 'package:flutter/material.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:emel/repository/morador_repository.dart';
import 'package:emel/repository/visitante_repository.dart';

class UsuarioSession extends ChangeNotifier {

  final usuarioBox = Hive.box("usuario");
  

  Future<void> salvarMorador(PostgrestMap morador) async {
    await usuarioBox.put("user", morador);

    try {
      MoradorRepository repository = MoradorRepository();
      int idMorador = morador["id_morador"];
      await repository.registrarTokenDispositivo(idMorador);
    } catch (e) {
      print("Erro ao tentar registrar o token do morador no login: $e");
    }

    notifyListeners();
  }

 Future<void> salvarVisitante(PostgrestMap visitante) async {
  // Salva o usuário na caixinha local
  await usuarioBox.put("user", visitante);
  
  // 2. Chama a nossa função para salvar o token!
  try {
    VisitanteRepository repository = VisitanteRepository();
    // Pegamos o ID diretamente dos dados do banco que acabaram de chegar
    int idVisitante = visitante["id_visitante"]; 
    await repository.registrarTokenDispositivo(idVisitante);
  } catch (e) {
    print("Erro ao tentar registrar o token no login: $e");
  }

  notifyListeners();
}

  String get nomeUsuario {
    final usuario = usuarioBox.get("user");

    if (usuario == null) {
      return "";
    }

    return usuario["nome"];
    
  }

  bool get permissaoUsuario {
    final usuario = usuarioBox.get("user");
    if (usuario == null){
      return false;
    }
    return usuario["permissao"];
    
  }

  int get idMorador {
    final usuario = usuarioBox.get("user");

    if (usuario == null) {
      return 0;
    }

    return usuario["id_morador"];
  }

  
  int get idVisitante {
    final usuario = usuarioBox.get("user");

    if (usuario == null) {
      return 0;
    }

    return usuario["id_visitante"];
  }

   int get idMoradorFk {
    final usuario = usuarioBox.get("user");

    if (usuario == null) {
      return 0;
    }

    return usuario["id_moradia_fk"];
  }


  Future<void> logoutUserSession() async {
    await usuarioBox.clear();
    notifyListeners();
  }

}
  // prováveis gets para o endereço, 
  //no caso a moradia do usuario deverão ser feitos