import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

class NotificacaoSession extends ChangeNotifier{
  final notifRecentesBox = Hive.box("notificacoes");

  Future<void> salvarNotificacoes(List<Map<String, dynamic>> notificacoes)async{
    int cont = 1;
    await notifRecentesBox.clear();
    for(var n in notificacoes){
      await notifRecentesBox.put("n$cont", n);
      cont++;
    }
    notifyListeners();
  }

  List<Map<String, dynamic>> get pegarNotificacoes{
    final List<Map<String, dynamic>> notif = [];
    for(int i=1; ; i++){
      final item = notifRecentesBox.get("n$i");
      if(item == null) break;
      notif.add(Map<String, dynamic>.from(item));
    }
    return notif;
  }
  Future<void> logoutNotifSession()async{
    await notifRecentesBox.clear();
    notifyListeners();
  }
}