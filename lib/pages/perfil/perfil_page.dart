import 'package:emel/pages/inicial_page.dart';
import 'package:emel/sessionRepository/usuario_session.dart';
import 'package:emel/widgets/img_perfil.dart';
import 'package:emel/widgets/default_layout.dart';
import 'package:emel/widgets/logout.dart';
import 'package:flutter/material.dart';
import 'package:emel/pages/perfil/help_page.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:provider/provider.dart';

class PerfilPage extends StatelessWidget {
  const PerfilPage({super.key});
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
          Logout.mostrarLogout(context, "morador");
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
                  Text("ID 000000", style: TextStyle(fontSize: 12)),
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

                        // botao2
                        Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 70,
                                width: 70,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF3299FF),
                                    // shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ), // aqui define o arredondamento
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.verified_user,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Text(
                                  "Credenciais",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // botao3
                        Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: Row(
                            children: [
                              SizedBox(
                                height: 70,
                                width: 70,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF0068FF),
                                    // shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        20,
                                      ), // aqui define o arredondamento
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.notification_add,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 25),
                                child: Text(
                                  "Notificar",
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

  // função para pop up de logout precisa estilizar a adicionar tudo aqui ainda
  void _mostrarDialogoLogout(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        // Arredonda as bordas do pop-up
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Finalizar Sessão',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D3B36), // Cor escura do título
          ),
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
              // Botão Sim (Principal)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const InicialPage()),
                  );
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00D294), // Verde da imagem
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  elevation: 0,
                ),
                child: const Text('Sim', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 10),
              // Botão Cancelar (Secundário)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE2F6E9), // Verde bem clarinho
                  foregroundColor: const Color(0xFF0D3B36), // Texto escuro
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
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

  // Exemplo de função fake de logout
  void _executarLogoutUsuario() {
    Hive.box("usuario").delete("morador");
    print("Usuário deslogado com sucesso!");
  }
}
