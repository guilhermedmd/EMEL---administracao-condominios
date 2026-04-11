import 'dart:ui';
import 'package:flutter/material.dart';

class TelaPagamentos extends StatelessWidget {
  const TelaPagamentos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pagamentos",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF000000),
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF00D09E),
        elevation: 0,
      ),

      body: Column(
        children: [
          Center(
            child: Container(
              width: double.infinity,
              height: 75,
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFFF1FFF3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Total pago este ano",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Color(0xFF093030),
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    "R\$ SemMundial",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: const BoxDecoration(
                color: Color(0xFFF1FFF3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
              ),

              child: ListView(
                children: [
                  const SizedBox(height: 15),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Janeiro",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ALTERADO: Adicionado 'context' como primeiro item em todas as chamadas
                  GastosMensais(
                    context,
                    "Condominio",
                    "20:22 - Jan 30",
                    "Mensal",
                    "R\$ 850,00",
                    Icons.home,
                  ),
                  GastosMensais(
                    context,
                    "Agua",
                    "14:57 - Jan 2",
                    "Mensal",
                    "R\$ 122,00",
                    Icons.water_drop,
                  ),
                  GastosMensais(
                    context,
                    "Energia",
                    "14:59 - Jan 2",
                    "Mensal",
                    "R\$ 162,00",
                    Icons.flash_on,
                  ),
                  GastosMensais(
                    context,
                    "Gás",
                    "15:05 - Jan 2",
                    "Mensal",
                    "R\$ 80,00",
                    Icons.local_fire_department,
                  ),

                  const SizedBox(height: 30),

                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "Fevereiro",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GastosMensais(
                    context,
                    "Condominio",
                    "10:00 - Fev 28",
                    "Mensal",
                    "R\$ 850,00",
                    Icons.home,
                  ),
                  GastosMensais(
                    context,
                    "Agua",
                    "14:57 - Fev 2",
                    "Mensal",
                    "R\$ 122,00",
                    Icons.water_drop,
                  ),
                  GastosMensais(
                    context,
                    "Energia",
                    "14:59 - Fev 2",
                    "Mensal",
                    "R\$ 162,00",
                    Icons.flash_on,
                  ),
                  GastosMensais(
                    context,
                    "Gás",
                    "15:05 - Fev 2",
                    "Mensal",
                    "R\$ 80,00",
                    Icons.local_fire_department,
                  ),

                  const SizedBox(height: 30),

                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "MARÇO",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GastosMensais(
                    context,
                    "Condominio",
                    "10:00 - Mar 28",
                    "Mensal",
                    "R\$ 850,00",
                    Icons.home,
                  ),
                  GastosMensais(
                    context,
                    "Agua",
                    "14:57 - Mar 2",
                    "Mensal",
                    "R\$ 122,00",
                    Icons.water_drop,
                  ),
                  GastosMensais(
                    context,
                    "Energia",
                    "14:59 - Mar 2",
                    "Mensal",
                    "R\$ 162,00",
                    Icons.flash_on,
                  ),
                  GastosMensais(
                    context,
                    "Gás",
                    "15:05 - Mar 2",
                    "Mensal",
                    "R\$ 80,00",
                    Icons.local_fire_department,
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ALTERADO: Adicionado 'BuildContext context' como primeiro parâmetro
  Widget GastosMensais(
    BuildContext context,
    String titulo,
    String data,
    String categoria,
    String valor,
    IconData icone,
  ) {
    // ALTERADO: Envolvido com InkWell para permitir o clique e navegação
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TelaComprovante(titulo: titulo, valor: valor, data: data),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Icon(icone, color: Colors.white),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          titulo,
                          style: const TextStyle(
                            color: Color(0xFF052224),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF0068FF),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: 30,
                    width: 1,
                    color: const Color(0xFF00D09E),
                  ),

                  Expanded(
                    flex: 3,
                    child: Center(
                      child: Text(
                        categoria,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),

                  Container(
                    height: 30,
                    width: 1,
                    color: const Color(0xFF00D09E),
                  ),

                  const SizedBox(width: 25),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: Text(
                valor,
                style: const TextStyle(
                  color: Color(0xFF052224),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- NOVA CLASSE: TELA DE COMPROVANTE ---
class TelaComprovante extends StatelessWidget {
  final String titulo;
  final String valor;
  final String data;

  const TelaComprovante({
    super.key,
    required this.titulo,
    required this.valor,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comprovante", style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0xFF00D09E),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(
                Icons.check_circle,
                color: Color(0xFF00D09E),
                size: 80,
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Pagamento Confirmado!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(height: 40),
            _linhaInfo("Serviço:", titulo),
            _linhaInfo("Data:", data),
            _linhaInfo("Valor:", valor),
            _linhaInfo("Tipo:", "Mensal"),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0068FF),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Voltar",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _linhaInfo(String label, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
          Text(info, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
