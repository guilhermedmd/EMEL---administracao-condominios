import 'package:emel/pages/PerfilPage.dart';
import 'package:flutter/material.dart';
import 'package:emel/pages/telaPagamentos.dart';

class InicialPage extends StatelessWidget {
  const InicialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6EFEA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// LOGO
              Column(
                children: const [
                  Icon(Icons.home_work, size: 70, color: Colors.black87),
                  SizedBox(height: 10),
                  Text(
                    'EMEL',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'EMPREENDIMENTOS\nIMOBILIÁRIOS',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              const Text(
                'SELECIONE O SEU PERFIL:',
                style: TextStyle(fontSize: 12),
              ),

              const SizedBox(height: 20),

              /// BOTÃO MORADOR
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PerfilPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00D09E),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'MORADOR',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              /// BOTÃO VISITANTE
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TelaPagamentos()), // rota pra tela pagamento
                    );
                    // TODO: tela do visitante
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4E2DB),
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'VISITANTE',
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
