import 'package:flutter/material.dart';
import 'package:emel/pages/login_page.dart';
import 'package:emel/pages/pagamentos_page.dart';

// Stateless pois a tela é estática
class InicialPage extends StatelessWidget {
  const InicialPage({super.key});

  @override
  Widget build(BuildContext context) {
    // [RC5] largura e altura para responsividade
    final double larguraTela = MediaQuery.of(context).size.width;
    final double alturaTela = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFE6EFEA),
      // [RC7] Uso de AppBar 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 40,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          // [RC5] - Scrollview conteúdo acessível no paisagem
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: alturaTela * 0.05),
                /// LOGO RESPONSIVA [RC5]
                Icon(
                  Icons.home_work, 
                  size: larguraTela * 0.2, // ícone se ajusta ao tamanho da tela
                  color: Colors.black87
                ),
                
                const SizedBox(height: 10),
                const Text(
                  'EMEL',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const Text(
                  'EMPREENDIMENTOS\nIMOBILIÁRIOS',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),

                const SizedBox(height: 60),

                const Text(
                  'SELECIONE O SEU PERFIL:',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 24),

                /// BOTÃO MORADOR [RC2] e [RC7]
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navegação para a tela de login
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00D09E),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('MORADOR', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                  ),
                ),

                const SizedBox(height: 16),

                /// BOTÃO VISITANTE 
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TelaPagamentos()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4E2DB),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('VISITANTE', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                  ),
                ),
                
                const SizedBox(height: 40), // para evitar que o botão encoste na borda 
              ],
            ),
          ),
        ),
      ),
    );
  }
}