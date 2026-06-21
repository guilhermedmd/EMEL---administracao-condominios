import 'package:flutter/material.dart';
import 'package:emel/widgets/default_layout.dart';
import 'package:emel/pages/navegacao_page.dart';

class NotificacaoPage extends StatelessWidget {
  const NotificacaoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00D09E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF052224)),
          onPressed: () {
            Navigator.maybePop(context);
          },
        ),
        title: const Text(
          "Histórico De Notificação",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF052224),
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: CircleAvatar(
              backgroundColor: const Color(0xFFFFA800),
              radius: 18,
              child: const Icon(
                Icons.notifications,
                size: 20,
                color: Color(0xFF052224),
              ),
            ),
          ),
        ],
      ),
      body: Defaultlayout(
        heightConst: 0.85,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Group: Hoje
                    const Text(
                      "Hoje",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF052224),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildNotifItem(
                      icon: Icons.check_circle_outline,
                      title: "Visita Liberada",
                      description: "José Pereira foi autorizado a entrar no condomínio.",
                      time: "17:00 - Maio 24",
                    ),
                    _buildNotifItem(
                      icon: Icons.event_available,
                      title: "Visita Agendada",
                      description: "Visita de Ana Souza cadastrada com sucesso.",
                      time: "16:00 - Maio 24",
                    ),
                    const SizedBox(height: 16),

                    // Group: Ontem
                    const Text(
                      "Ontem",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF052224),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildNotifItem(
                      icon: Icons.event_busy,
                      title: "Visita Cancelada",
                      description: "A visita de Fernanda Silva foi cancelada",
                      time: "17:00 - Maio 23",
                    ),
                    _buildNotifItem(
                      icon: Icons.access_time,
                      title: "Liberar Visita",
                      description: "João está na portaria!",
                      time: "17:00 - Abril 24",
                    ),
                    const SizedBox(height: 16),

                    // Group: Essa semana
                    const Text(
                      "Essa semana",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF052224),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildNotifItem(
                      icon: Icons.event_available,
                      title: "Visita Agendada",
                      description: "Visita de Gabriel cadastrada com sucesso.",
                      time: "17:00 - Abril 24",
                    ),
                    _buildNotifItem(
                      icon: Icons.event_available,
                      title: "Visita Agendada",
                      description: "Visita de Paola cadastrada com sucesso.",
                      time: "17:00 - Abril 24",
                      isLast: true,
                    ),
                  ],
                ),
              ),
            ),
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildNotifItem({
    required IconData icon,
    required String title,
    required String description,
    required String time,
    bool isLast = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Green circle icon
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF00D09E),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: const Color(0xFF052224),
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF0E3E3E),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Color(0xFF0E3E3E),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        time,
                        style: const TextStyle(
                          color: Color(0xFF0068FF),
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            color: const Color(0xFF00D09E).withOpacity(0.3),
            thickness: 1,
            height: 1,
          ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      color: const Color(0xFFF1FFF3), // Matches Defaultlayout background
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
        child: Container(
          height: 80,
          color: const Color(0xFFDFF7E2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Clock Icon (Histórico)
              IconButton(
                icon: const Icon(
                  Icons.history,
                  color: Color(0xFF031314),
                  size: 28,
                ),
                onPressed: () {
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => const NavegacaoPage(initialIndex: 0),
                  //   ),
                  //   (route) => false,
                  // );
                },
              ),
              // Home Icon
              IconButton(
                icon: const Icon(
                  Icons.home_outlined,
                  color: Color(0xFF031314),
                  size: 28,
                ),
                onPressed: () {
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => const NavegacaoPage(initialIndex: 1),
                  //   ),
                  //   (route) => false,
                  // );
                },
              ),
              // Person Icon (Perfil)
              IconButton(
                icon: const Icon(
                  Icons.person_outline,
                  color: Color(0xFF031314),
                  size: 28,
                ),
                onPressed: () {
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => const NavegacaoPage(initialIndex: 2),
                  //   ),
                  //   (route) => false,
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
