import 'package:emel/widgets/default_layout.dart';
import 'package:emel/widgets/form_login_morador.dart';
import 'package:emel/widgets/form_login_visitante.dart';
import 'package:flutter/material.dart';

class LoginVisitantePage extends StatelessWidget{

  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Text(
                "Bem Vindo Visitante!",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Defaultlayout(
                child: FormLoginVisitante()
              ),
            ),
          ],
        ),
      ),
    );
  }
}