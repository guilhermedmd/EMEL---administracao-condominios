import 'package:flutter/material.dart';

class Notificacaoicons {
  IconData getIconeNotificacao(String tipo){
    switch (tipo){
      case "Entrega":
      return Icons.delivery_dining_rounded;

      case "Visita":
      return Icons.group;

      case "Prestação de serviço":
      return Icons.work;

      case "Aviso":
      return Icons.warning_amber;

      default:
      return Icons.notifications;
    }
  }
}

// create type tipo_notificacao as ENUM('Entrega', 'Visita', 'Prestação de serviço', 'Aviso', 'Outro');
