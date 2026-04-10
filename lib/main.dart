import 'package:emel/pages/PerfilPage.dart';
import 'package:emel/pages/SplashPage.dart';
import 'package:emel/pages/login_page.dart';
import 'package:emel/pages/navegacao_page.dart';
import 'package:emel/pages/telaPagamentos.dart';
import 'package:emel/widget/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  // Essa linha evita aquele erro de carregamento que tivemos antes
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF00D09E),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(
            0xFF00D09E,
          ), 
          primary: const Color(0xFF00D09E),
          surface: const Color(
            0xFFE3EDE8,
          ), 
        ),
        // Isso aqui padroniza a fonte para o app TODO:
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: LoginPage(),
    ),
  );
}
