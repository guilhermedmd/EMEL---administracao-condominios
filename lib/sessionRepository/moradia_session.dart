import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MoradiaSession extends ChangeNotifier{
  final moradiaBox = Hive.box("moradia");

  Future<void> salvarMoradia(PostgrestMap moradia) async{
    await moradiaBox.put("moradia", moradia);
    notifyListeners();
  }
  String get getBloco {
    final moradia = moradiaBox.get("moradia");

    if (moradia == null) {
      throw Exception("informações não encontradas");
    }

    return moradia["bloco"];
  }

  int get getNumero {
    final moradia = moradiaBox.get("moradia");

    if (moradia == null) {
      throw Exception("informações não encontradas");
    }

    return moradia["numero"];
  }


  Future<void> logoutMoradiaSession()async{
    await moradiaBox.clear();
    notifyListeners();
  }
}