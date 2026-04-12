import 'package:emel/pages/login_page.dart';
import 'package:emel/pages/navegacao_page.dart';
import 'package:emel/widget/ImgPerfil.dart';
import 'package:emel/widget/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:emel/pages/perfil%20pages/help_page.dart';

class PerfilPage extends StatelessWidget {
  final String nomeUsuario;
  const PerfilPage({super.key, required this.nomeUsuario});
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Perfil", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Navigator.pop(context);
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
                  Text(
                    nomeUsuario,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
            // AQUI entra só a ação de navegar:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HelpPage()),
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
}
