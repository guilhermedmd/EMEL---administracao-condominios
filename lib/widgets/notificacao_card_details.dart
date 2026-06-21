import 'package:emel/widgets/notificacaoIcons.dart';
import 'package:flutter/material.dart';

class NotificacaoCardDetails {
 static Widget notifCard(String titulo, String descricao,String dataHora, bool isLast, String tipo){
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Green circle icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF00D09E),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Icon(
                    Notificacaoicons().getIconeNotificacao(tipo),
                    color: const Color(0xFF052224),
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: const TextStyle(
                        color: Color(0xFF0E3E3E),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      descricao,
                      style: const TextStyle(
                        color: Color(0xFF0E3E3E),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        dataHora,
                        style: const TextStyle(
                          color: Color(0xFF0068FF),
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            color: const Color(0xFF00D09E).withOpacity(0.3),
            thickness: 1,
            height: 1,
          ),
      ],
    );
 }
    
}