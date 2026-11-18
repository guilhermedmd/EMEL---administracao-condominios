import 'package:emel/controllers/visita_controller.dart';
import 'package:emel/pages/navegacao_page.dart';
import 'package:emel/utils/formator_datas.dart';
import 'package:emel/utils/seletor_data_hora.dart';
import 'package:emel/widgets/cancelar_visita.dart';
import 'package:emel/widgets/default_layout.dart';
import 'package:flutter/material.dart';

class AgendamentoDetalhesScreen extends StatefulWidget {
  final int? idVisita;
  final String dataHora;
  final String? dataSaida;
  final String observacoes;
  final List<String> visitantes;
  final String tipoVisita;
  final bool possuiPermissao;

  const AgendamentoDetalhesScreen({
    super.key,
    required this.idVisita,
    required this.dataHora,
    required this.observacoes,
    required this.visitantes,
    required this.tipoVisita,
    required this.possuiPermissao,
    required this.dataSaida
  });

  @override
  State<AgendamentoDetalhesScreen> createState() =>
      _AgendamentoDetalhesScreenState();
}

class _AgendamentoDetalhesScreenState extends State<AgendamentoDetalhesScreen> {
  late bool _permissao;
  late String _dataHoraAtual;
  late String? _dataSaida;
  DateTime? dataVisita;

  List<String> _separandoDataHora(String dataHora) {
    List<String> horaData = dataHora.split("-");
    if (horaData.length < 2) {
      return [dataHora, ''];
    }
    return horaData;
  }

  @override
  void initState() {
    super.initState();
    _permissao = widget.possuiPermissao;
    _dataHoraAtual = widget.dataHora;
    _dataSaida = widget.dataSaida;
  }

  bool get _exibirBotoesAcao {
    final dataAgendada = dataVisita ?? FormatadorDatas().paraDateTime(_dataHoraAtual);
    final bool isPassed = dataAgendada.isBefore(DateTime.now());
    return _permissao && (_dataSaida == "" || _dataSaida == null) && !isPassed;
  }

  @override
  Widget build(BuildContext context) {
    const corVerdePrincipal = Color(0xFF00D09E);
    const corTextoEscuro = Color(0xFF093030);
    const corBordaCard = Color(0xFF9BE3C4);
    List<String> horaData = _separandoDataHora(_dataHoraAtual);

    return Scaffold(
      backgroundColor: corVerdePrincipal,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: Defaultlayout(
        heightConst: 0.85,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        // Badge superior "Agendamento"
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 44,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: corVerdePrincipal,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            'Agendamento',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: corTextoEscuro,
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // Card de Horário e Data
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    color: Color(0xFF1E1E1E),
                                    size: 28,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    horaData[0],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF1E1E1E),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.calendar_today_outlined,
                                    color: Color(0xFF1E1E1E),
                                    size: 26,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    horaData[1],
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF1E1E1E),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 26),

                        // Cards lado a lado: Observações e Visitantes
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Card Observações
                            Expanded(
                              flex: 11,
                              child: Container(
                                height: 240,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(28),
                                  border: Border.all(
                                    color: corBordaCard,
                                    width: 1.2,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Observações',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: corTextoEscuro,
                                      ),
                                    ),
                                    const SizedBox(height: 14),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                        ),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            widget.observacoes,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              height: 1.3,
                                              color: Color(0xFF222222),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(width: 14),

                            // Card Visitantes
                            Expanded(
                              flex: 9,
                              child: Container(
                                height: 240,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(28),
                                  border: Border.all(
                                    color: corBordaCard,
                                    width: 1.2,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Visitantes',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: corTextoEscuro,
                                      ),
                                    ),
                                    const SizedBox(height: 14),
                                    Expanded(
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: widget.visitantes.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              bottom: 4,
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  '• ',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF222222),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    widget.visitantes[index],
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xFF222222),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Card Tipo de Visita
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(color: corBordaCard, width: 1.2),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Tipo De Visita:',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: corTextoEscuro,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  widget.tipoVisita,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF222222),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),

                        // Botões condicionais
                        if (_exibirBotoesAcao) ...[
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    CancelarVisita.mostrarPopUp(
                                      context,
                                      widget.idVisita ?? 0,
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFF32459),
                                    foregroundColor: corTextoEscuro,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: const Text(
                                    'Cancelar Visita',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 24),
                              Expanded(
                                child: ElevatedButton(
                                 onPressed: () async {
                                    final novaDataHora = await selecionarDataHora(
                                      context: context,
                                      valorInicial: dataVisita,
                                      dataMinima: DateTime.now(),
                                    );

                                    if (novaDataHora != null) {
                                      final hora = novaDataHora.hour.toString().padLeft(2, '0');
                                      final minuto = novaDataHora.minute.toString().padLeft(2, '0');
                                      final dia = novaDataHora.day.toString().padLeft(2, '0');
                                      final mes = novaDataHora.month.toString().padLeft(2, '0');
                                      final ano = novaDataHora.year.toString();
                                      // Provavelmente aqui entrará o novo endpoint
                                      setState(() {
                                        dataVisita = novaDataHora;
                                        _dataHoraAtual = '$hora:$minuto-$dia/$mes/$ano';
                                        VisitaController().editarDataHora(novaDataHora, widget.idVisita ?? 0);
                                      });
                                      Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(builder: (_) => const NavegacaoPage(indice: 1,)),
                                    );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF7D9285),
                                    foregroundColor: corTextoEscuro,
                                    elevation: 0,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: const Text(
                                    'Remarcar Visita',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}