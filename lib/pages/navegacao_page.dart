import 'package:emel/pages/ferramentas_page.dart';
import 'package:flutter/material.dart';
import 'package:emel/pages/perfil/perfil_page.dart';
import 'package:emel/pages/historico_liberacoes.dart';

class NavegacaoPage extends StatefulWidget {
  const NavegacaoPage({super.key});

  @override
  State<NavegacaoPage> createState() => _NavegacaoPageState();
}

class _NavegacaoPageState extends State<NavegacaoPage> {
  int _indiceAtual = 0; // Começa no Perfil
  static const corBotoes = 0xff031314;


  @override
  Widget build(BuildContext context) {
    final List<Widget> _telas = [
    Center(child: Text("Home em breve")),
    TelaHistoricoLiberacoes(),
    FerramentasPage(),
          PerfilPage(), 
  ];
    return Scaffold(
      body: _telas[_indiceAtual], 
      
      bottomNavigationBar: Padding(
  padding: const EdgeInsets.all(0),
  child: Container(
    color: const Color(0xFFf4fcf4),
    child: ClipRRect(
    borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
    child: NavigationBar(
      height: 80,
      backgroundColor: const Color(0xFFDFF7E2),
      indicatorColor: const Color(0xFF00D09E),
      selectedIndex: _indiceAtual,
      onDestinationSelected: (index) {
        setState(() {
          _indiceAtual = index;
        });
      },
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home, color: Color(corBotoes),),
          label: '',
        ),
        NavigationDestination(
          icon: Icon(Icons.payments_outlined),
          selectedIcon: Icon(Icons.payments, color: Color(corBotoes)),
          label: '',
        ),
        NavigationDestination(
          icon: Icon(Icons.layers_outlined),
          selectedIcon: Icon(Icons.layers, color: Color(corBotoes)),
          label: '',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          selectedIcon: Icon(Icons.person, color: Color(corBotoes)),
          label: '',
        ),
      ],
    ),
  
),
  )
    )
    );
  }
}