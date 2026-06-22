import 'package:emel/widgets/notificacaoIcons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VisitaAgendaCard {
  Widget cardVisita(String nomeMorador, String observacao, String tipo, String dataHora,
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: const Color(0xFF00D09E),
          child: Icon(
            Notificacaoicons().getIconeNotificacao(tipo),
            color: Colors.white,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Morador: $nomeMorador",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF052224),
                ),
              ),

              const SizedBox(height: 4),

              Text(
                "Tipo: $tipo",
                style: const TextStyle(
                  color: Color(0xFF00D09E),
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "Observação: $observacao",
                style: const TextStyle(
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    dataHora,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}