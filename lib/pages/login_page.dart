import 'package:emel/widget/default_layout.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  Widget build(BuildContext context) {
    final laguraTela = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Text(
                "Bem Vindo",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Defaultlayout(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: laguraTela * 0.30),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 30),
                              child: SizedBox(
                                width: laguraTela * 0.75,

                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: (laguraTela * 0.75) * 0.55,
                                      ),
                                      child: Padding(padding: EdgeInsets.only(bottom: 10), child:Text("Nome de Usuário:",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                      ),), 
                                      ),
                                      
                                    ),
                                    TextField(
                                       style: TextStyle(
                                      color: Color(0xff0E3E3E)
                                    ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                          borderSide: BorderSide.none,
                                        ),

                                        fillColor: Color(0xFFDFF7E2),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              width: laguraTela * 0.75,

                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      right: (laguraTela * 0.75) * 0.75,
                                    ),
                                    child: Padding(padding: EdgeInsets.only(bottom: 10), child: Text("Senha:",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                    ),),)
                                  ),
                                  TextField(
                                    obscureText: true,
                                    style: TextStyle(
                                      color: Color(0xff0E3E3E)
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                        borderSide: BorderSide.none,
                                      ),

                                      fillColor: Color(0xffdcf4e4),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF00D09E),
                          foregroundColor: Colors.black,
                           padding: EdgeInsets.symmetric(
                          horizontal: 84,
                          vertical: 24,
                        )
                        ), 
                        child: Text("Log in",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        )
                        ),
                        ),
                      Padding(padding: EdgeInsets.only(top: 20),
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          overlayColor: WidgetStateProperty.all(Colors.transparent),
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text("Esqueceu sua senha?", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff0E3E3E)),),
                      ),
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
