import 'dart:ui';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class TelaPagamentos extends StatelessWidget {
  const TelaPagamentos({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pagamentos",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF000000),
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
                  Text(
                    "Total pago este ano",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: const Color(0xFF093030),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "R\$ 4.250,00",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF000000),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 140),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFF1FFF3),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80),
                  topRight: Radius.circular(80),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}