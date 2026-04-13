import 'package:emel/widgets/default_layout.dart';
import 'package:emel/widgets/form_login.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  Widget build(BuildContext context) {
  
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
                child: FormLogin()
              ),
            ),
          ],
        ),
      ),
    );
  }
}
