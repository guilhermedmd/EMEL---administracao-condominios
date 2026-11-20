import 'package:emel/widgets/default_layout.dart';
import 'package:emel/widgets/form_login_morador.dart';
import 'package:emel/widgets/form_login_visitante.dart';
import 'package:flutter/material.dart';

class LoginVisitantePage extends StatelessWidget {
  const LoginVisitantePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Text(
                "Bem-Vindo Visitante!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Defaultlayout(
                child: FormLoginVisitante(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}