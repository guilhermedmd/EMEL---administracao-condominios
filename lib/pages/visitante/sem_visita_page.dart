import 'package:flutter/material.dart';
import 'package:emel/widgets/default_layout.dart';

class SemVisitaPage extends StatelessWidget {
  final VoidCallback? onAtualizar;

  const SemVisitaPage({super.key, this.onAtualizar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      backgroundColor: const Color(0xFF00D294),
      body: Stack(
        children: [
          // Cabeçalho verde com botão voltar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, top: 8),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ),

          Defaultlayout(
            heightConst: 0.84,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                children: [
                  // Pílula título "Visita"
                  Container(
                    width: 220,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D294),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'Visita',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D3B36),
                      ),
                    ),
                  ),

                  const SizedBox(height: 64),

                  // Card informativo de ausência de visita
                  Container(
                    width: double.infinity,
                    height: 210,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFFA8E6C1),
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Você não possui nenhuma\nvisita agendada para a\npróxima hora',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF0D3B36),
                            height: 1.35,
                          ),
                        ),
                        if (onAtualizar != null) ...[
                          const SizedBox(height: 16),
                          IconButton(
                            icon: const Icon(
                              Icons.refresh,
                              color: Color(0xFF00D294),
                              size: 28,
                            ),
                            tooltip: 'Verificar novamente',
                            onPressed: onAtualizar,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
