import 'package:emel/widgets/default_layout.dart';
import 'package:emel/widgets/form_login_morador.dart';
import 'package:flutter/material.dart';

class LoginMoradorPage extends StatelessWidget {
  Widget build(BuildContext context) {
  
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Text(
                "Bem-Vindo Morador!",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Defaultlayout(
                child: FormLoginMorador()
              ),
            ),
          ],
        ),
      ),
    );
  }
}
