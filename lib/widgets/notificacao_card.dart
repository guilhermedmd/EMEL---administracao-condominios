import 'package:flutter/material.dart';

class NotificacaoCard {
  static Widget card(BuildContext context, String titulo, String dataHora){
     return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFF6DA2FC),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.check,
                color: Color(0xFF052224),
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: const TextStyle(
                    color: Color(0xFF0E3E3E),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  dataHora,
                  style: const TextStyle(
                    color: Color(0xFF0068FF),
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  
}
  }