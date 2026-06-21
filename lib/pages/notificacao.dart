import 'package:emel/controllers/notificacaoController.dart';
import 'package:emel/sessionRepository/usuario_session.dart';
import 'package:emel/widgets/notificacao_card_details.dart';
import 'package:flutter/material.dart';
import 'package:emel/widgets/default_layout.dart';
import 'package:provider/provider.dart';

class NotificacaoPage extends StatefulWidget {
  const NotificacaoPage({super.key});

  @override
  State<NotificacaoPage> createState() => _NotificacaoPageState();
}

class _NotificacaoPageState extends State<NotificacaoPage> {
  final Notificacaocontroller _notificacaocontroller = Notificacaocontroller();
  List<Map<String, dynamic>> notifEsteMes = [];
  List<Map<String, dynamic>> notifAnteriores = [];

  @override
  void initState() {
    super.initState();
    carregarNotificacoes();
  }

  Future<void> carregarNotificacoes() async {
    UsuarioSession session = context.read<UsuarioSession>();
    int idMorador = session.idMorador;
    var dados = await _notificacaocontroller.todasNotificacoes(idMorador);
    setState(() {
      notifEsteMes = dados.$1;
      notifAnteriores = dados.$2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00D09E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actionsPadding: EdgeInsets.only(
          right: MediaQuery.of(context).size.width * 0.050,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF052224)),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
        title: const Text(
          "Histórico De Notificação",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF052224),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundColor: const Color(0xFFFFA800),
              radius: 18,
              child: const Icon(
                Icons.notifications,
                size: 20,
                color: Color(0xFF052224),
              ),
            ),
          ),
        ],
      ),
      body: Defaultlayout(
        heightConst: 0.85,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(80),
            topRight: Radius.circular(80),
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.075,
                    vertical: MediaQuery.of(context).size.height * 0.070,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (notifEsteMes.isEmpty && notifAnteriores.isEmpty)
                        const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.notifications_off,
                                size: 80,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Você ainda não possui notificações",
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        )
                      else ...[
                        const Text(
                          "Estes Mês:",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF052224),
                          ),
                        ),
                        // listview este mes
                        if (notifEsteMes.isNotEmpty)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: notifEsteMes.length,
                            itemBuilder: (context, index) {
                              final notificacao = notifEsteMes[index];
                              return NotificacaoCardDetails.notifCard(
                                notificacao["titulo"],
                                notificacao["descricao"],
                                notificacao["data_horario"],
                                false,
                                notificacao["tipo"],
                              );
                            },
                          )
                        else
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: Text("Nenhuma notificação neste mês"),
                            ),
                          ),

                        const SizedBox(height: 8),

                        const SizedBox(height: 16),
                        if (notifAnteriores.isNotEmpty) ...[
                          const Text(
                            "Anteriores:",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF052224),
                            ),
                          ),
                          const SizedBox(height: 8),
                          // listview anteriores
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: notifAnteriores.length,
                            itemBuilder: (context, index) {
                              final notificacao = notifAnteriores[index];
                              return NotificacaoCardDetails.notifCard(
                                notificacao["titulo"],
                                notificacao["descricao"],
                                notificacao["data_horario"],
                                false,
                                notificacao["tipo"],
                              );
                            },
                          ),
                        ] else
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Center(
                              child: Text("Nenhuma notificação neste mês"),
                            ),
                          ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
