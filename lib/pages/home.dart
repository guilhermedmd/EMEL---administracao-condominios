import 'package:emel/sessionRepository/notificacao_session.dart';
import 'package:emel/widgets/notificacao_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:emel/sessionRepository/usuario_session.dart';
import 'package:emel/widgets/default_layout.dart';
import 'package:emel/pages/notificacao.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:emel/sessionRepository/usuario_session.dart';
import 'package:emel/widgets/default_layout.dart';
import 'package:emel/pages/notificacao.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00D09E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Home",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF052224),
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.065),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: IconButton(
                icon: const Icon(
                  Icons.notifications_none,
                  size: 20,
                  color: Color(0xFF052224),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NotificacaoPage()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: Defaultlayout(
        heightConst: 0.85,
        // 1. Trocamos o SingleChildScrollView externo por um Padding
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting and House Card Row (FIXO)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                    Consumer<UsuarioSession>(
                      builder: (context, session, child) {
                        final String nome = session.nomeUsuario.isNotEmpty
                            ? session.nomeUsuario
                            : "Usuário";
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Olá,",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0E3E3E),
                              ),
                            ),
                            Text(
                              nome,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00D09E),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  SizedBox(width: MediaQuery.of(context).size.width *0.2),
                  Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D09E),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomPaint(
                          size: const Size(60, 50),
                          painter: HouseIconPainter(),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          "CASA X",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Action Buttons Container (FIXO)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5F6EC),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      // onTap: () {...},
                      child: Column(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Color(0xFF00D09E),
                              size: 36,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Agendar\nVisita",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF0E3E3E),
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CustomPaint(
                              size: const Size(38, 38),
                              painter: HandKeyIconPainter(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Liberar\nVisita",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF0E3E3E),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),

              // Title "Ultimas Notificações:" (FIXO)
              const Text(
                "Ultimas Notificações:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF052224),
                ),
              ),
              const SizedBox(height: 12),

              // 2. Colocamos as notificações em um Expanded + SingleChildScrollView
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Consumer<NotificacaoSession>(
              builder: (context, notificacaoSession, child) {
          final lista = notificacaoSession.pegarNotificacoes;
                      if (lista.isEmpty) {
            return Center(child: Text("Nenhuma notificação por enquanto."));
          }
          return ListView.builder(
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true, // Adicione se estiver direto na Column sem Expanded por fora do Consumer
    itemCount: lista.length,
    itemBuilder: (context, index) {
      final notificacao = lista[index];
      return NotificacaoCard.card(context, notificacao["titulo"], notificacao["data_horario"]);
    },
  );
          }
                      ),
                      // Aqui entra o listView.builder
                      
                      // "Ver Todas" Button
                      Center(
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00D09E),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              elevation: 0,
                            ),
                            child: const Text(
                              "Ver Todas",
                              style: TextStyle(
                                color: Color(0xFF052224),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
// Icones personalizados
class HouseIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // Roof
    final roofPath = Path()
      ..moveTo(w * 0.1, h * 0.5)
      ..lineTo(w * 0.5, h * 0.15)
      ..lineTo(w * 0.9, h * 0.5);
    canvas.drawPath(roofPath, paint);

    // Chimney (on the right)
    final chimneyPath = Path()
      ..moveTo(w * 0.72, h * 0.35)
      ..lineTo(w * 0.72, h * 0.22)
      ..lineTo(w * 0.8, h * 0.22)
      ..lineTo(w * 0.8, h * 0.42);
    canvas.drawPath(chimneyPath, paint);

    // Main body
    final bodyPath = Path()
      ..moveTo(w * 0.18, h * 0.5)
      ..lineTo(w * 0.18, h * 0.9)
      ..lineTo(w * 0.82, h * 0.9)
      ..lineTo(w * 0.82, h * 0.5);
    canvas.drawPath(bodyPath, paint);

    // Door
    final doorPath = Path()
      ..moveTo(w * 0.42, h * 0.9)
      ..lineTo(w * 0.42, h * 0.65)
      ..lineTo(w * 0.58, h * 0.65)
      ..lineTo(w * 0.58, h * 0.9);
    canvas.drawPath(doorPath, paint);
    
    // Door knob
    canvas.drawCircle(Offset(w * 0.45, h * 0.78), 1.0, paint..style = PaintingStyle.fill);
    paint.style = PaintingStyle.stroke; // restore style

    // Left Window
    final leftWindowRect = Rect.fromLTRB(w * 0.25, h * 0.58, w * 0.35, h * 0.72);
    canvas.drawRect(leftWindowRect, paint);
    // Grid inside window
    canvas.drawLine(Offset(w * 0.3, h * 0.58), Offset(w * 0.3, h * 0.72), paint);
    canvas.drawLine(Offset(w * 0.25, h * 0.65), Offset(w * 0.35, h * 0.65), paint);

    // Right Window
    final rightWindowRect = Rect.fromLTRB(w * 0.65, h * 0.58, w * 0.75, h * 0.72);
    canvas.drawRect(rightWindowRect, paint);
    // Grid inside window
    canvas.drawLine(Offset(w * 0.7, h * 0.58), Offset(w * 0.7, h * 0.72), paint);
    canvas.drawLine(Offset(w * 0.65, h * 0.65), Offset(w * 0.75, h * 0.65), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class HandKeyIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00D09E)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;

    // Hand outline (palm facing up)
    final handPath = Path()
      ..moveTo(w * 0.1, h * 0.7)
      ..quadraticBezierTo(w * 0.25, h * 0.6, w * 0.35, h * 0.6)
      ..lineTo(w * 0.6, h * 0.6)
      // Thumb
      ..quadraticBezierTo(w * 0.65, h * 0.5, w * 0.55, h * 0.45)
      ..quadraticBezierTo(w * 0.48, h * 0.45, w * 0.42, h * 0.5)
      ..moveTo(w * 0.6, h * 0.6)
      // Fingers
      ..lineTo(w * 0.8, h * 0.6)
      ..quadraticBezierTo(w * 0.9, h * 0.6, w * 0.95, h * 0.53)
      ..quadraticBezierTo(w * 1.0, h * 0.45, w * 0.9, h * 0.4)
      ..lineTo(w * 0.65, h * 0.4);
    canvas.drawPath(handPath, paint);

    // Key (lying above the hand)
    // Key head on the left, shaft to the right
    final keyHeadCenter = Offset(w * 0.4, h * 0.25);
    final keyHeadRadius = w * 0.1;
    canvas.drawCircle(keyHeadCenter, keyHeadRadius, paint);
    
    // Key shaft
    canvas.drawLine(Offset(w * 0.5, h * 0.25), Offset(w * 0.82, h * 0.25), paint);
    
    // Key teeth
    canvas.drawLine(Offset(w * 0.68, h * 0.25), Offset(w * 0.68, h * 0.33), paint);
    canvas.drawLine(Offset(w * 0.76, h * 0.25), Offset(w * 0.76, h * 0.33), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
