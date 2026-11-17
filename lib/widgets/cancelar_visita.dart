import 'package:emel/controllers/visita_controller.dart';
import 'package:emel/pages/historico_liberacoes_page.dart';
import 'package:emel/pages/inicial_page.dart';
import 'package:emel/pages/navegacao_page.dart';
import 'package:emel/sessionRepository/moradia_session.dart';
import 'package:emel/sessionRepository/notificacao_session.dart';
import 'package:emel/sessionRepository/usuario_session.dart';
import 'package:flutter/material.dart';

class CancelarVisita {
  static void mostrarPopUp(BuildContext context, int idVisita) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Cancelamento de visita',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D3B36)),
          ),
          content: const Text(
            'Quer mesmo cancelar essa visita?',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          actions: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () async{
                    // endpoint que deleta a visita com base no id
                    await VisitaController().deletarVisitaPorId(idVisita);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const NavegacaoPage(indice: 1,)),
                    );

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00D294),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    elevation: 0,
                  ),
                  child: const Text('Sim', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE2F6E9),
                    foregroundColor: const Color(0xFF0D3B36),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    elevation: 0,
                  ),
                  child: const Text('Não', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
