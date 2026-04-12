import 'dart:ui';
import 'package:flutter/material.dart';

class TelaPagamentos extends StatelessWidget {
  TelaPagamentos({super.key});

  final List<Map<String, dynamic>> meses = [
    {
      "mes": "Janeiro",
      "gastos": [
        {
          "titulo": "Condominio",
          "data": "20:22 - Jan 30",
          "categoria": "Mensal",
          "valor": 600.00,
          "icone": Icons.home,
        },
        {
          "titulo": "Agua",
          "data": "14:57 - Jan 2",
          "categoria": "Mensal",
          "valor": 122.00,
          "icone": Icons.water_drop,
        },
        {
          "titulo": "Energia",
          "data": "14:59 - Jan 2",
          "categoria": "Mensal",
          "valor": 162.00,
          "icone": Icons.flash_on,
        },
        {
          "titulo": "Gás",
          "data": "15:05 - Jan 2",
          "categoria": "Mensal",
          "valor": 80.00,
          "icone": Icons.local_fire_department,
        },
      ],
    },

    {
      "mes": "Fevereiro",
      "gastos": [
        {
          "titulo": "Condominio",
          "data": "13:00 - Fev 28",
          "categoria": "Mensal",
          "valor": 600.00,
          "icone": Icons.home,
        },
        {
          "titulo": "Agua",
          "data": "12:12 - Fev 2",
          "categoria": "Mensal",
          "valor": 109.00,
          "icone": Icons.water_drop,
        },
        {
          "titulo": "Energia",
          "data": "14:15 - Fev 2",
          "categoria": "Mensal",
          "valor": 150.00,
          "icone": Icons.flash_on,
        },
        {
          "titulo": "Gás",
          "data": "15:05 - Fev 2",
          "categoria": "Mensal",
          "valor": 80.00,
          "icone": Icons.local_fire_department,
        },
      ],
    },

    {
      "mes": "Março",
      "gastos": [
        {
          "titulo": "Condominio",
          "data": "09:00 - Mar 30",
          "categoria": "Mensal",
          "valor": 600.00,
          "icone": Icons.home,
        },
        {
          "titulo": "Agua",
          "data": "20:12 - Mar 2",
          "categoria": "Mensal",
          "valor": 115.00,
          "icone": Icons.water_drop,
        },
        {
          "titulo": "Energia",
          "data": "20:16 - Mar 2",
          "categoria": "Mensal",
          "valor": 142.00,
          "icone": Icons.flash_on,
        },
        {
          "titulo": "Gás",
          "data": "15:37 - Mar 2",
          "categoria": "Mensal",
          "valor": 80.00,
          "icone": Icons.local_fire_department,
        },
      ],
    },
  ];

  double calcularTotal() {
    double total = 0;

    for (var mes in meses) {
      for (var gasto in mes["gastos"]) {
        total += gasto["valor"];
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                  Text(
                    "R\$ ${calcularTotal().toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 80),

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

                  ...meses.map((mes) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            mes["mes"],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        ...mes["gastos"].map<Widget>((gasto) {
                          return gastosMensais(
                            context,
                            gasto["titulo"],
                            gasto["data"],
                            gasto["categoria"],
                            "R\$ ${gasto["valor"].toStringAsFixed(2)}",
                            gasto["icone"],
                          );
                        }).toList(),

                        const SizedBox(height: 30),
                      ],
                    );
                  }),

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
  Widget gastosMensais(
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
                  style: TextStyle(color: Colors.white),
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
