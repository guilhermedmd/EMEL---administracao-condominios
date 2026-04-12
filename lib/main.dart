import 'package:emel/pages/SplashPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  // Essa linha evita aquele erro de carregamento que tivemos antes
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: const Color(0xFF00D09E),
      // Isso aqui padroniza a fonte para o app TODO:
      textTheme: GoogleFonts.poppinsTextTheme(), 
    ),
    home: SplashPage(),
  ));
}
