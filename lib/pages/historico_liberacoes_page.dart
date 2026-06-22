import 'package:emel/controllers/notificacaoController.dart';
import 'package:emel/controllers/visita_controller.dart';
import 'package:emel/sessionRepository/usuario_session.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TelaHistoricoLiberacoes extends StatefulWidget {
  const TelaHistoricoLiberacoes({super.key});

  @override
  State<TelaHistoricoLiberacoes> createState() =>
      _TelaHistoricoLiberacoesState();
}

class _TelaHistoricoLiberacoesState extends State<TelaHistoricoLiberacoes> {
  final VisitaController _visitaController = VisitaController();
  final Notificacaocontroller _notificacaocontroller = Notificacaocontroller();
  int _qtdeVisitas = 0;
  int _qtdePrestadores = 0;
  int _qtdeVisitantes = 0;
  int _qtdeEntregas = 0;

Future<void> carregarEstatisticas()async{
            UsuarioSession sessionUsuario = context.read<UsuarioSession>();
            int idMorador = sessionUsuario.idMorador;
            int qtdeVisitas = await _visitaController.buscarQtdeVisitas(idMorador);
            int qtdePrestadores = await _visitaController.buscarQtdePrestadoresServico(idMorador);
            int qtdeVisitantes = await _visitaController.buscarQtdeVisitantes(idMorador);
            int qtdeEntregas = await _notificacaocontroller.buscarQtdeEntregas(idMorador);
            setState(() {
              _qtdeVisitas = qtdeVisitas; 
              _qtdePrestadores = qtdePrestadores; 
              _qtdeVisitantes = qtdeVisitantes; 
              _qtdeEntregas = qtdeEntregas; 
            });
  }
  @override
  void initState() {
    super.initState();
    initializeDateFormatting('pt_BR', null);
    carregarEstatisticas();
  }

  

  Future<List<Map<String, dynamic>>> _buscarHistorico() async {
    try {
      final supabase = Supabase.instance.client;

      final response = await supabase
    .from('visita')
    .select('''
      data_hora_entrada,
      tipo,
      observacao,
      participantes_visita(
        visitante(
          nome
        )
      )
    ''')
    .eq('id_morador_fk', 1)
    .not('data_hora_saida', 'is', null);

      final List<dynamic> data = response as List<dynamic>;

     return data.map((item) {
  String nome = 'Sem nome';

  if (item['participantes_visita'] != null &&
      item['participantes_visita'].isNotEmpty) {
    nome = item['participantes_visita'][0]['visitante']['nome'] ?? 'Sem nome';
  }

  return {
    "nome": nome,
    "data": _formatarData(item['data_hora_entrada']),
    "categoria": item['tipo'] ?? 'Outros',
    "status": item["observacao"],
    "icone": _obterIconePorCategoria(item['tipo']),
  };
}).toList();
    } catch (e) {
      debugPrint('Erro ao buscar dados: $e');
      return [];
    }
  }

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
      backgroundColor: const Color(0xFF00D09E), 
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                    _infoText("Total De Visitas", "$_qtdeVisitas"),
                    Container(height: 30, width: 1, color: Colors.white54),
                    _infoText("Prestadores Ativos", "$_qtdePrestadores"),
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
                        "$_qtdeVisitantes",
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _cardInfo(Icons.card_giftcard, "Entregas", "$_qtdeEntregas"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                
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
                          padding: EdgeInsets.zero,
                          physics: const BouncingScrollPhysics(),
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
