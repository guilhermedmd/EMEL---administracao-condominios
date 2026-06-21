import 'package:emel/pages/inicial_page.dart';
import 'package:emel/sessionRepository/moradia_session.dart';
import 'package:emel/sessionRepository/usuario_session.dart';
import 'package:emel/widgets/img_perfil.dart';
import 'package:emel/widgets/default_layout.dart';
import 'package:emel/widgets/logout.dart';
import 'package:flutter/material.dart';
import 'package:emel/pages/perfil/help_page.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:provider/provider.dart';

class PerfilVisitantePage extends StatelessWidget {
  const PerfilVisitantePage({super.key});
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Perfil", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Logout.mostrarLogout(context, "visitante");
        },
        backgroundColor: Color(0xFFE3EDE8),
        child: Icon(Icons.logout),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,

      body: Defaultlayout(
        heightConst: 0.70,
        child: Stack(
          // Deixa a imagem de perfil vazar para fora
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Consumer<UsuarioSession>(
                    builder: (context, usuarioSession, child) {
                      return Text(
                        usuarioSession.nomeUsuario,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    width: larguraTela * 0.75,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // botao 1
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 70,
                                width: 70,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF6DB6FE),
                                    // shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ), // aqui define o arredondamento
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.people_alt,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Text(
                                  "Editar perfil",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Botão 4
                        Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 70,
                                width: 70,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HelpPage(),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF6DB6FE),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.support_agent,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Text(
                                  "Help",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(top: -110, child: Imgperfil()),
          ],
        ),
      ),
    );
  }

 
  // Exemplo de função fake de logout
  void _executarLogoutUsuario() {
    Hive.box("usuario").delete("morador");
    print("Usuário deslogado com sucesso!");
  }
}
