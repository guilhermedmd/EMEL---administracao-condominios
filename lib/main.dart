import 'package:emel/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    theme: ThemeData(
      scaffoldBackgroundColor: const Color(0xFF00D09E),
      textTheme: GoogleFonts.poppinsTextTheme(), 
    ),
    home: SplashPage(),
  ));
}
