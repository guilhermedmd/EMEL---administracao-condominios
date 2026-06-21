import 'package:emel/pages/inicial_page.dart';
import 'package:emel/sessionRepository/notificacao_session.dart';
import 'package:emel/sessionRepository/usuario_session.dart';
import 'package:flutter/material.dart';

class Logout {
  static void mostrarLogout(BuildContext context, String tipoUsuario) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Finalizar Sessão',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D3B36)),
          ),
          content: const Text(
            'Quer mesmo finalizar a sessão?',
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
                    await UsuarioSession().logoutUserSession();
                    await NotificacaoSession().logoutNotifSession();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const InicialPage()),
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
                  child: const Text('Cancelar', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
