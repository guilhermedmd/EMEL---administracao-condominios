import 'package:flutter/material.dart';
import 'package:emel/widgets/default_layout.dart';

class HomeVisitantePage extends StatelessWidget {
  const HomeVisitantePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Início", 
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D3B36)),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, 
      ),
      body: Defaultlayout(
        heightConst: 0.70, // Mantive a mesma proporção que você usou no Perfil
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Ícone de boas-vindas
              const Icon(
                Icons.waving_hand_rounded,
                size: 80,
                color: Color(0xFF00D294), // Verde da sua paleta
              ),
              const SizedBox(height: 20),
              
              // Título
              const Text(
                "Olá, Visitante!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF052224),
                ),
              ),
              const SizedBox(height: 10),
              
              // Subtítulo
              const Text(
                "Seja bem vindo(a)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 50),

              // Card simulando alguma informação vazia (Placeholder)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE3EDE8), // Fundo clarinho
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.qr_code_scanner, 
                      color: Color(0xFF0D3B36),
                      size: 30,
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Nenhum acesso",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF0D3B36),
                            ),
                          ),
                          Text(
                            "Você não possui convites ativos.",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}