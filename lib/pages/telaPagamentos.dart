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

          const SizedBox(height: 130), // separa os containers

          Expanded(
            // tela braca ..
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

                  GastosMensais(
                    // condominio
                    "Condominio",
                    "20:22 - Jan 30",
                    "Mensal",
                    "R\$ 850,00",
                    Icons.home,
                  ),

                  GastosMensais(
                    // Agua
                    "Agua",
                    "14:57 - Jan 2",
                    "Mensal",
                    "R\$ 122,00",
                    Icons.water_drop,
                  ),

                  GastosMensais(
                    // condominio
                    "Energia",
                    "14:59 - Jan 2",
                    "Mensal",
                    "R\$ 162,00",
                    Icons.flash_on,
                  ),

                  GastosMensais(
                    // condominio
                    "Gás",
                    "15:05 - Jan 2",
                    "Mensal",
                    "R\$ 80,00",
                    Icons.local_fire_department,
                  ),
                  const SizedBox(height: 30),

                  // --- SEÇÃO FEVEREIRO ---
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
                    "Condominio",
                    "10:00 - Fev 28",
                    "Mensal",
                    "R\$ 850,00",
                    Icons.home,
                  ),

                  GastosMensais(
                    // Agua
                    "Agua",
                    "14:57 - Fev 2",
                    "Mensal",
                    "R\$ 122,00",
                    Icons.water_drop,
                  ),

                  GastosMensais(
                    // condominio
                    "Energia",
                    "14:59 - Fev 2",
                    "Mensal",
                    "R\$ 162,00",
                    Icons.flash_on,
                  ),

                  GastosMensais(
                    "Gás",
                    "15:05 - Fev 2",
                    "Mensal",
                    "R\$ 80,00",
                    Icons.local_fire_department,
                  ),

                  const SizedBox(
                    height: 40,
                  ), // Espaço no final para não ficar colado
                  // --- SEÇÃO MARCO ---
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
                    "Condominio",
                    "10:00 - Mar 28",
                    "Mensal",
                    "R\$ 850,00",
                    Icons.home,
                  ),

                  GastosMensais(
                    // Agua
                    "Agua",
                    "14:57 - Mar 2",
                    "Mensal",
                    "R\$ 122,00",
                    Icons.water_drop,
                  ),

                  GastosMensais(
                    // condominio
                    "Energia",
                    "14:59 - Mar 2",
                    "Mensal",
                    "R\$ 162,00",
                    Icons.flash_on,
                  ),

                  GastosMensais(
                    "Gás",
                    "15:05 - Mar 2",
                    "Mensal",
                    "R\$ 80,00",
                    Icons.local_fire_department,
                  ),

                  const SizedBox(
                    height: 40,
                  ), // Espaço no final para não ficar colado
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget GastosMensais(
    String titulo,
    String data,
    String categoria,
    String valor,
    IconData icone,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Icon(icone, color: Colors.white),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Row(
              children: [
                // Nome + data
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

                // barra 1
                Container(height: 30, width: 1, color: const Color(0xFF00D09E)),

                // Categoria (mensal)
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      categoria,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),

                // barra 2
                Container(height: 30, width: 1, color: const Color(0xFF00D09E)),

                const SizedBox(width: 25),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.only(right: 18),
            child: Text(
              valor,
              style: TextStyle(
                color: Color(0xFF052224),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
