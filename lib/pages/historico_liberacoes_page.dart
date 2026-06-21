import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TelaHistoricoLiberacoes extends StatefulWidget {
  const TelaHistoricoLiberacoes({super.key});

  @override
  State<TelaHistoricoLiberacoes> createState() =>
      _TelaHistoricoLiberacoesState();
}

class _TelaHistoricoLiberacoesState extends State<TelaHistoricoLiberacoes> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR', null);
  }

  Future<List<Map<String, dynamic>>> _buscarHistorico() async {
    try {
      final supabase = Supabase.instance.client;

      // 1. Mudamos para .select('*') para evitar erros de relacionamento agora
      final response = await supabase
          .from('visita')
          .select('*')
          .order('data_hora_entrada', ascending: false);

      final List<dynamic> data = response as List<dynamic>;

      // 2. Substitua o mapa antigo por este novo:
      return data.map((item) {
        return {
          // Aqui usamos o ID (chave estrangeira) pois o nome do visitante ainda não veio
          "nome": "Visitante ID: ${item['id_visitante_fk'] ?? 'Sem ID'}",
          "data": _formatarData(item['data_hora_entrada']),
          "categoria": item['tipo'] ?? 'Outros',
          "status": 'Concluído',
          "icone": _obterIconePorCategoria(item['tipo']),
        };
      }).toList();
    } catch (e) {
      debugPrint('Erro ao buscar dados: $e');
      return [];
    }
  }

  // Função para formatar a data que vem do banco
  String _formatarData(String? dataBanco) {
    if (dataBanco == null) return '';
    try {
      DateTime data = DateTime.parse(dataBanco);
      // Formata para: "12:43 - Dezembro 13"
      String hora = DateFormat('HH:mm').format(data);
      String mesDia = DateFormat('MMMM dd', 'pt_BR').format(data);
      // Capitaliza a primeira letra do mês
      mesDia = mesDia[0].toUpperCase() + mesDia.substring(1);
      return "$hora - $mesDia";
    } catch (e) {
      return '';
    }
  }

  IconData _obterIconePorCategoria(String? categoria) {
    switch (categoria?.toLowerCase()) {
      case 'visitante':
        return Icons.vpn_key_outlined;
      case 'encomenda':
      case 'entrega':
        return Icons.card_giftcard;
      case 'carona autorizada':
      case 'carona':
        return Icons.directions_bus_outlined;
      case 'prestador':
        return Icons.confirmation_number_outlined;
      default:
        return Icons.info_outline;
    }
  }

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
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: _buscarHistorico(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF00D09E),
                            ),
                          );
                        }

                        if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                              "Erro ao carregar o histórico.",
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        }

                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text("Nenhuma liberação encontrada."),
                          );
                        }

                        final listaHistorico = snapshot.data!;

                        return ListView.builder(
                          itemCount: listaHistorico.length,
                          itemBuilder: (context, index) {
                            final item = listaHistorico[index];
                            return _itemLiberacao(
                              nome: item["nome"],
                              data: item["data"],
                              categoria: item["categoria"],
                              status: item["status"],
                              icone: item["icone"],
                            );
                          },
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
