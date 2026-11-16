import 'package:emel/widgets/default_layout.dart';
import 'package:flutter/material.dart';
// Importe o arquivo onde está o seu Defaultlayout

class AgendamentoDetalhesScreen extends StatelessWidget {
  final String dataHora;
  // final String dataHoraEntrada;
  final String observacoes;
  final List<String> visitantes;
  final String tipoVisita;
  final bool possuiPermissao;

  const AgendamentoDetalhesScreen({
    super.key,
    required this.dataHora,
    // required this.dataHoraEntrada,
    required this.observacoes,
    required this.visitantes,
    required this.tipoVisita,
    required this.possuiPermissao
  });

  /// Regra de validação para exibir os botões de ação.
  bool get _exibirBotoesAcao {
    return possuiPermissao;
  }

  @override
  Widget build(BuildContext context) {
    const corVerdePrincipal = Color(0xFF00D09E);
    const corTextoEscuro = Color(0xFF093030);
    const corBordaCard = Color(0xFF9BE3C4);

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
                                    dataHora,
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
                                    dataHora,
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

                        // Cards lado a lado: Observações e Visitantes (com rolagem interna)
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
                                            observacoes,
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
                                        itemCount: visitantes.length,
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
                                                    visitantes[index],
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
                            border: Border.all(
                              color: corBordaCard,
                              width: 1.2,
                            ),
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
                                  tipoVisita,
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
                                  onPressed: (){},
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
                                  onPressed: (){},
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