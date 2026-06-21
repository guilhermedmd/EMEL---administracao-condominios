import 'package:flutter/material.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UsuarioSession extends ChangeNotifier {

  final usuarioBox = Hive.box("usuario");

  Future<void> salvarMorador(PostgrestMap morador) async {
    await usuarioBox.put("user", morador);
    notifyListeners();
  }

  Future<void> salvarVisitante(PostgrestMap visitante) async {
    await usuarioBox.put("user", visitante);
    notifyListeners();
  }

  String get nomeUsuario {
    final usuario = usuarioBox.get("user");

    if (usuario == null) {
      return "";
    }

    return usuario["nome"];
  }

  int get idMorador {
    final usuario = usuarioBox.get("user");

    if (usuario == null) {
      return 0;
    }

    return usuario["id_morador"];
  }

  Future<void> logoutUserSession() async {
    await usuarioBox.clear();
    notifyListeners();
  }

}
  // prováveis gets para o endereço, 
  //no caso a moradia do usuario deverão ser feitos