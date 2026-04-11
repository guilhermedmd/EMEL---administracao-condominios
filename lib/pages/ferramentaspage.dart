import 'package:flutter/material.dart';
import 'package:emel/widget/default_layout.dart';

class FerramentasPage extends StatelessWidget {
  const FerramentasPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. PRIMEIRO declaramos os dados (Hardcoded para o RC4)
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
      {'icon': Icons.payments, 'label': 'Contas'},
      {'icon': Icons.history, 'label': 'Histórico'},
      {'icon': Icons.settings, 'label': 'Ajustes'},
      {'icon': Icons.groups, 'label': 'Comunidade'},
    ];

    // 2. DEPOIS retornamos o Widget
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ferramentas", // Corrigi de 'Pagamentos' para 'Ferramentas'
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF00D09E),
        elevation: 0,
      ),
      body: Defaultlayout(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // 3 colunas como você pediu
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 10, // Aumentei um pouco para não sufocar o texto
                    childAspectRatio: 0.8, 
                  ),
                  itemCount: ferramentas.length,
                  itemBuilder: (context, index) {
                    return InkWell( // Adicionei um efeito de toque
                      onTap: () => print("Clicou em: ${ferramentas[index]['label']}"),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE3F2FD),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Icon(
                              ferramentas[index]['icon'],
                            color: Colors.blue,
                              size: 40,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            ferramentas[index]['label'],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
    );
  }
}
