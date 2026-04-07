import 'package:emel/widget/img_perfil.dart';
import 'package:emel/widget/DefaultLayout.dart';
import 'package:flutter/material.dart';

class Perfilpage extends StatelessWidget {
  Widget build(BuildContext context) {
    final largura_tela = MediaQuery.of(context).size.width;

    return Defaultlayout(
      title: "Perfil",
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
                  "Nome",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text("ID 000000", style: TextStyle(fontSize: 12)),
                SizedBox(
                  width: largura_tela * 0.75,
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
                        padding: EdgeInsets.only(top: 25),
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
                                  Icons.support_agent,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ),
                            Padding(
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
          Positioned(top: -110, child: img_perfil()),
        ],
      ),
    );
  }
}
