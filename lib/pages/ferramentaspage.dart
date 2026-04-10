import 'package:flutter/material.dart';
import 'package:emel/widget/default_layout.dart';

class FerramentasPage extends StatelessWidget {
  const FerramentasPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista de itens (Dados hardcoded como pede o RC4)
    final List<Map<String, dynamic>> ferramentas = [
      {'icon': Icons.build, 'label': 'Manutenção'},
      {'icon': Icons.router, 'label': 'Redes'},
      {'icon': Icons.fitness_center, 'label': 'Treino'},
      {'icon': Icons.local_shipping, 'label': 'Caminhões'},
      {'icon': Icons.payments, 'label': 'Contas'},
      {'icon': Icons.history, 'label': 'Histórico'},
      {'icon': Icons.settings, 'label': 'Ajustes'},
      {'icon': Icons.groups, 'label': 'Comunidade'},
      {'icon': Icons.help_outline, 'label': 'Suporte'},
    ];

    return Defaultlayout(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Ferramentas",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 itens por linha
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.85, // Ajusta a altura dos quadradinhos
                ),
                itemCount: ferramentas.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE3F2FD), // Azul clarinho da sua foto
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(
                          ferramentas[index]['icon'],
                          color: Colors.blueAccent,
                          size: 30,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        ferramentas[index]['label'],
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}