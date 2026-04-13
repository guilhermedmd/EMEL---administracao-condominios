import 'package:flutter/material.dart';
import 'package:emel/pages/inicial_page.dart';


//um StatefulWidget pois ela muda de estado
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});


  @override
  State<SplashPage> createState() => _SplashPageState();
}


class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();


    // [RC2] Navegação com pushReplacement
    //Cria um atraso de 2 segundos
    Future.delayed(const Duration(seconds: 2), () {
      //substitui a tela atual pela próxima
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const InicialPage()),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    // [RC5] Responsividade
    final double screenHeight = MediaQuery.of(context).size.height;


    return Scaffold(
      // [RC6] cor de fundo do ThemeData
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // children ficar um embaixo do outro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //exbir a casa
          children: [
            Icon(Icons.home_work, size: screenHeight * 0.1, color: Colors.black87),
            const SizedBox(height: 20),
            const Text(
              'EMEL',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'EMPREENDIMENTOS\nIMOBILIÁRIOS',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}