import 'package:emel/pages/ferramentaspage.dart';
import 'package:flutter/material.dart';
import 'package:emel/pages/Perfil%20pages/PerfilPage.dart';
import 'package:emel/pages/telaPagamentos.dart';

class NavegacaoPage extends StatefulWidget {
  const NavegacaoPage({super.key});

  @override
  State<NavegacaoPage> createState() => _NavegacaoPageState();
}

// ... seus imports

class _NavegacaoPageState extends State<NavegacaoPage> {
  int _indiceAtual = 0; // Começa no Perfil

  final List<Widget> _telas = [
    const Center(child: Text("Home em breve")),
    TelaPagamentos(),
    const FerramentasPage(),
          PerfilPage(), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_indiceAtual], 
      
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: (index) {
          setState(() {
            _indiceAtual = index;
          });
        },
        // --- AJUSTES DE HOVER E ESTILO ---
        type: BottomNavigationBarType.fixed, // Garante que os ícones não se mexam
        selectedItemColor: const Color(0xFF00D09E), // Verde EMEL quando clicado
        unselectedItemColor: Colors.grey, // Cinza quando não clicado
        showSelectedLabels: false, // Esconde o espaço da legenda
        showUnselectedLabels: false,
        iconSize: 28,
        
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.payments), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.layers), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''), // Camadas (Ferramentas)
        ],
      ),
    );
  }
}