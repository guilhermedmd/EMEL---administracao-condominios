import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:emel/controllers/visita_controller.dart';
import 'package:emel/pages/visitante/acompanhamento_visita.dart';
import 'package:emel/pages/visitante/home_visitante_page.dart';
import 'package:emel/pages/visitante/perfil_visitante_page.dart';
import 'package:emel/pages/visitante/sem_visita_page.dart';
import 'package:emel/sessionRepository/usuario_session.dart';
import 'package:emel/utils/formator_datas.dart';

class NavegacaoPageVisitante extends StatefulWidget {
  const NavegacaoPageVisitante({super.key});

  @override
  State<NavegacaoPageVisitante> createState() => _NavegacaoPageVisitanteState();
}

class _NavegacaoPageVisitanteState extends State<NavegacaoPageVisitante> {
  int _indiceAtual = 0;
  static const corBotoes = 0xff031314;
  final GlobalKey<_AbaVisitaRouterState> _visitaKey = GlobalKey<_AbaVisitaRouterState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<UsuarioSession>(
      builder: (context, usuarioSession, child) {
        final int idVisitante = usuarioSession.idVisitante;

        final List<Widget> telas = [
          
          HomeVisitantePage(),
          _AbaVisitaRouter(
            key: _visitaKey,
            idVisitante: idVisitante,
          ),
          const PerfilVisitantePage(),
        ];

        return Scaffold(
          body: IndexedStack(
            index: _indiceAtual,
            children: telas,
          ),
          bottomNavigationBar: Container(
            color: const Color(0xFFf4fcf4),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
              child: NavigationBar(
                height: 65,
                backgroundColor: const Color(0xFFDFF7E2),
                indicatorColor: const Color(0xFF00D09E),
                selectedIndex: _indiceAtual,
                onDestinationSelected: (index) {
                  setState(() {
                    _indiceAtual = index;
                  });
                  if (index == 1) {
                    _visitaKey.currentState?.verificarVisita();
                  }
                },
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home, color: Color(corBotoes)),
                    label: '',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.timer_outlined),
                    selectedIcon: Icon(Icons.timer, color: Color(corBotoes)),
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
          ),
        );
      },
    );
  }
}

class _AbaVisitaRouter extends StatefulWidget {
  final int idVisitante;

  const _AbaVisitaRouter({
    super.key,
    required this.idVisitante,
  });

  @override
  State<_AbaVisitaRouter> createState() => _AbaVisitaRouterState();
}

class _AbaVisitaRouterState extends State<_AbaVisitaRouter> {
  final VisitaController _visitaController = VisitaController();
  Map<String, dynamic>? _visitaEncontrada;
  bool _isLoading = true;

  int get _idVisitanteEfetivo {
    if (widget.idVisitante > 0) return widget.idVisitante;
    return UsuarioSession().idVisitante;
  }

  @override
  void initState() {
    super.initState();
    verificarVisita();
  }

  @override
  void didUpdateWidget(covariant _AbaVisitaRouter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.idVisitante != widget.idVisitante) {
      verificarVisita();
    }
  }

  Future<void> verificarVisita() async {
    if (!mounted) return;
    setState(() => _isLoading = true);

    try {
      final int id = _idVisitanteEfetivo;
      final dados = await _visitaController.buscarVisitaProximaHora(id);
      if (mounted) {
        setState(() {
          _visitaEncontrada = dados;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _visitaEncontrada = null;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF00D294),
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      );
    }

    if (_visitaEncontrada == null) {
      return SemVisitaPage(
        onAtualizar: verificarVisita,
      );
    }

    final rawVisita = _visitaEncontrada!['visita'];
    final Map<String, dynamic> dadosVisita = rawVisita is Map<String, dynamic>
        ? rawVisita
        : (rawVisita is List && rawVisita.isNotEmpty
            ? Map<String, dynamic>.from(rawVisita.first)
            : {});

    final int idVisita = _visitaEncontrada!['id_visita_fk'] ??
        dadosVisita['id_visita'] ??
        0;
    final morador = dadosVisita['morador'];
    final String nomeMorador = morador is Map && morador['nome'] != null
        ? morador['nome'].toString()
        : 'Morador';

    final dataChegada = FormatadorDatas()
        .converterParaDataLocal(_visitaEncontrada!['data_chegada']);
    final dataEntrada = FormatadorDatas()
        .converterParaDataLocal(_visitaEncontrada!['data_entrada']);
    final int? tempoAtendimento =
        (_visitaEncontrada!['tempo_atendimento'] as num?)?.toInt();
    final String? statusAtendimento =
        _visitaEncontrada!['status_atendimento']?.toString();

    return AcompanhamentoVisitaPage(
      key: ValueKey('visita_$idVisita'),
      idVisita: idVisita,
      idVisitante: _idVisitanteEfetivo,
      nomeMorador: nomeMorador,
      dataChegada: dataChegada,
      dataEntrada: dataEntrada,
      tempoAtendimento: tempoAtendimento,
      statusAtendimento: statusAtendimento,
      onAtualizar: verificarVisita,
    );
  }
}
