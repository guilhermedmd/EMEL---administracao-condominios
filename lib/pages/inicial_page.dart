import 'package:flutter/material.dart';
import 'package:emel/pages/login_page.dart';

//Stateless pois não muda
class InicialPage extends StatelessWidget {
  const InicialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE6EFEA),
      // [RC7] Uso de AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 40,
      ),
      //
      body: SafeArea(
        child: Padding(
          //para que não batam nas bordas
          padding: const EdgeInsets.symmetric(horizontal: 24),
          // [RC5] SingleChildScrollView para ser responsivo 
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                /// LOGO
                const Icon(Icons.home_work, size: 70, color: Colors.black87),
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

                /// BOTÃO VISITANTE [RC2]
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD4E2DB),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('VISITANTE', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                  ),
                ),
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

}