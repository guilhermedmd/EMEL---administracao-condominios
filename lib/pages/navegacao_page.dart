import 'package:flutter/material.dart';
import 'package:emel/pages/PerfilPage.dart';
import 'package:emel/pages/telaPagamentos.dart';

class NavegacaoPage extends StatefulWidget {
  const NavegacaoPage({super.key});

  @override
  State<NavegacaoPage> createState() => _NavegacaoPageState();
}

class _NavegacaoPageState extends State<NavegacaoPage> {
  int _indiceAtual = 2; // Controla qual tela aparece

  // Lista das telas que você já tem
  final List<Widget> _telas = [
    const Center(child: Text("Home em breve")), // Tela 1 (Home)
    const TelaPagamentos(),                     // Tela 2
          PerfilPage(),                         // Tela 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Aqui o Flutter decide qual tela mostrar baseado no clique
      body: _telas[_indiceAtual], 
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (index) {
          setState(() {
            _indiceAtual = index; // Muda a tela quando você clica
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 30,), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.payments, size: 30,), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person, size: 30,), label: ''),
        ],
      ),
    );
  }
}