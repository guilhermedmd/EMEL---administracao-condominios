import 'package:emel/controllers/visita_controller.dart';
import 'package:emel/pages/informacoes_visita_page.dart';
import 'package:emel/sessionRepository/usuario_session.dart';
import 'package:emel/utils/formator_datas.dart';
import 'package:emel/widgets/visita_agenda_card.dart';
import 'package:flutter/material.dart';
import 'package:emel/widgets/default_layout.dart';
import 'package:provider/provider.dart';

class HomeVisitantePage extends StatefulWidget {
  State<HomeVisitantePage> createState() => _HomeVisitantePageState();
}

class _HomeVisitantePageState extends State<HomeVisitantePage> {
  final VisitaController _visitaController = VisitaController();
  List<dynamic> listaVistas = [];
  bool isLoading = true;

  Future<void> carregarDados() async {
    try {
      UsuarioSession sessionUsuario = context.read<UsuarioSession>();
      int idVisitante = sessionUsuario.idVisitante;

      // Ajustado para passar a variável idVisitante corretamente
      List<dynamic> list = await _visitaController.buscarVisitasAgendadas(idVisitante);

      if (mounted) {
        setState(() {
          listaVistas = List.from(list);
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint('Erro ao carregar visitas do visitante: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Início",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D3B36),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Defaultlayout(
        heightConst: 0.80,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.waving_hand_rounded,
                size: 80,
                color: Color(0xFF00D294),
              ),
              const SizedBox(height: 20),
              Consumer<UsuarioSession>(
                builder: (context, usuarioSession, child) {
                  return Text(
                    usuarioSession.nomeUsuario,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF052224),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
              const Text(
                "Seja bem-vindo(a)",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 30),

              // Mudança principal: Envolver o Container em um Expanded
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3EDE8),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ), 
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isLoading)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else if (listaVistas.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            "Você não possui convites ativos no momento.",
                            style: TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                        )
                      else
                        Expanded(
                          child: Scrollbar(
                            thumbVisibility: true,
                            child: ListView.builder(
                              padding: const EdgeInsets.only(top: 10), // Respiro superior
                              physics: const BouncingScrollPhysics(),
                              itemCount: listaVistas.length,
                              itemBuilder: (context, index) {
                                final item = listaVistas[index];
                                final dadosVisita = item["visita"];

                                if (dadosVisita == null) {
                                  return const SizedBox();
                                }

                                final morador = dadosVisita["morador"];
                                final nomeMorador = morador != null
                                    ? morador["nome"]
                                    : "Não informado";
                                final condominio = morador != null
                                    ? morador["condominio"]
                                    : null;
                                final String? urlMapaCondominio = condominio != null
                                    ? (condominio["Token_Acesso"] ??
                                            condominio["token_acesso"])
                                        ?.toString()
                                    : null;
                                final String dataEntradaFormatada =
                                    FormatadorDatas()
                                        .formatarData(dadosVisita["data_hora_entrada"])
                                        .toString();
                                final String? dataSaidaFormatada =
                                    dadosVisita["data_hora_saida"] != null
                                        ? FormatadorDatas()
                                            .formatarData(dadosVisita["data_hora_saida"])
                                            .toString()
                                        : null;
                                final String observacao =
                                    dadosVisita["observacao"]?.toString() ?? "";
                                final String tipoVisita =
                                    dadosVisita["tipo"]?.toString() ?? "";

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      debugPrint(
                                        'URL mapa condomínio (visita ${dadosVisita["id_visita"]}): $urlMapaCondominio',
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AgendamentoDetalhesScreen(
                                            idVisita: dadosVisita["id_visita"],
                                            dataHora: dataEntradaFormatada,
                                            dataSaida: dataSaidaFormatada,
                                            observacoes: observacao,
                                            visitantes: [nomeMorador.toString()],
                                            tipoVisita: tipoVisita,
                                            possuiPermissao: true,
                                            isVisitante: true,
                                            urlMapaCondominio: urlMapaCondominio,
                                            tempoAtendimento: item["tempo_atendimento"] as int?,
                                            statusAtendimento: item["status_atendimento"]?.toString(),
                                          ),
                                        ),
                                      );
                                    },
                                    child: VisitaAgendaCard().cardVisita(
                                      nomeMorador.toString(),
                                      observacao,
                                      tipoVisita,
                                      dataEntradaFormatada,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
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