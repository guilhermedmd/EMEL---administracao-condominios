import 'package:flutter/material.dart';

class TelaHistoricoLiberacoes extends StatefulWidget {
  const TelaHistoricoLiberacoes({super.key});

  @override
  State<TelaHistoricoLiberacoes> createState() =>
      _TelaHistoricoLiberacoesState();
}

class _TelaHistoricoLiberacoesState extends State<TelaHistoricoLiberacoes> {
  // Nova estrutura de dados baseada na imagem
  final List<Map<String, dynamic>> liberacoes = [
    {
      "nome": "Alvarez Azevedo",
      "data": "12:43 - Dezembro 13",
      "categoria": "Visitante",
      "status": "Entrada\nLiberada",
      "icone": Icons.vpn_key_outlined,
    },
    {
      "nome": "Entrega Shopee",
      "data": "12:54 - Dezembro 12",
      "categoria": "Encomenda",
      "status": "Recebido\nNa Portaria",
      "icone": Icons.card_giftcard,
    },
    {
      "nome": "Motorista Luís",
      "data": "7:15 - Agosto 10",
      "categoria": "Carona\nAutorizada",
      "status": "Entrada\nConcluída",
      "icone": Icons.directions_bus_outlined,
    },
    {
      "nome": "Carlos (Pintor)",
      "data": "8:00 - Agosto 08",
      "categoria": "Prestador",
      "status": "Saída\nRegistrada",
      "icone": Icons.confirmation_number_outlined,
    },
    {
      "nome": "Stephen Curry",
      "data": "19:30 - Agosto 05",
      "categoria": "Visitante",
      "status": "Entrada\nLiberada",
      "icone": Icons.sports_basketball,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00D09E), // Fundo verde superior
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF052224)),
          onPressed: () {}, // Ação de voltar
        ),
        title: const Text(
          "Histórico De Liberações",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF052224),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: IconButton(
                icon: const Icon(
                  Icons.notifications_none,
                  size: 20,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // CABEÇALHO COM ESTATÍSTICAS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                // Totais
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _infoText("Total De Visitas", "32"),
                    Container(height: 30, width: 1, color: Colors.white54),
                    _infoText("Prestadores Ativos", "2"),
                  ],
                ),
                const SizedBox(height: 20),

                // Cards de Visitantes e Entregas
                Row(
                  children: [
                    Expanded(
                      child: _cardInfo(
                        Icons.person_outline,
                        "Visitantes",
                        "24",
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _cardInfo(Icons.card_giftcard, "Entregas", "8"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Mensagem de sucesso
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Todos Os Seus Convidados Foram\nIdentificados Com Sucesso ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF052224),
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                    Icon(
                      Icons.check_box_outlined,
                      size: 16,
                      color: Color(0xFF052224),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // CORPO (BOTTOM SHEET FIXO)
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
              decoration: const BoxDecoration(
                color: Color(0xFFF6FFF8),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título e botão "See all"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Últimas Liberações",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF052224),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "See all",
                          style: TextStyle(color: Colors.black54, fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Lista de Liberações
                  Expanded(
                    child: ListView.builder(
                      itemCount: liberacoes.length,
                      itemBuilder: (context, index) {
                        final item = liberacoes[index];
                        return _itemLiberacao(
                          nome: item["nome"],
                          data: item["data"],
                          categoria: item["categoria"],
                          status: item["status"],
                          icone: item["icone"],
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
    );
  }

  // --- WIDGETS AUXILIARES ---

  Widget _infoText(String label, String valor) {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.open_in_new, size: 12, color: Color(0xFF052224)),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 12, color: Color(0xFF052224)),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          valor,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _cardInfo(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: const Color(0xFF052224)),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF052224)),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF052224),
            ),
          ),
        ],
      ),
    );
  }

  Widget _itemLiberacao({
    required String nome,
    required String data,
    required String categoria,
    required String status,
    required IconData icone,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Ícone circular azul
            Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                color: Color(0xFF6DA2FC),
                shape: BoxShape.circle,
              ),
              child: Icon(icone, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 15),

            // Nome e Data
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    nome,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF052224),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    data,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0068FF),
                    ),
                  ),
                ],
              ),
            ),

            // Divisor
            const VerticalDivider(
              color: Color(0xFF00D09E),
              thickness: 1,
              indent: 5,
              endIndent: 5,
            ),

            // Categoria
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  categoria,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 11, color: Colors.black87),
                ),
              ),
            ),

            // Divisor
            const VerticalDivider(
              color: Color(0xFF00D09E),
              thickness: 1,
              indent: 5,
              endIndent: 5,
            ),

            // Status Final
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  status,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0068FF),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
