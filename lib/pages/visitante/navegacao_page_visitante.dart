import 'package:emel/pages/ferramentas_page.dart';
import 'package:emel/pages/historico_liberacoes_page.dart';
import 'package:emel/pages/home.dart';
import 'package:emel/pages/visitante/home_visitante_page.dart';
import 'package:emel/pages/visitante/perfil_visitante_page.dart';
import 'package:flutter/material.dart';
import 'package:emel/pages/perfil/perfil_page.dart';
import 'package:emel/pages/pagamentos_page.dart';

class NavegacaoPageVisitante extends StatefulWidget {
  const NavegacaoPageVisitante({super.key});

  @override
  State<NavegacaoPageVisitante> createState() => _NavegacaoPageVisitanteState();
}

class _NavegacaoPageVisitanteState extends State<NavegacaoPageVisitante> {
  int _indiceAtual = 0; // Começa no Perfil
  static const corBotoes = 0xff031314;


  @override
  Widget build(BuildContext context) {
    final List<Widget> _telas = [
    HomeVisitantePage(),
    PerfilVisitantePage(),
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
      height: 65,
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
          icon: Icon(Icons.person_2_outlined),
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