import 'package:emel/pages/navegacao_page.dart';
import 'package:emel/pages/splash_page.dart';
import 'package:emel/repository/morador_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('usuario');
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!
  );
  // teste de conexão com o supabase, por enquanto manter comentado
  //  try {

  //   MoradorRepository moradorRepository =
  //       MoradorRepository();

  //   List<dynamic> moradores =
  //       await moradorRepository.getMorador();

  //   print(moradores);

  // } catch (e) {

  //   print("ERRO NO SUPABASE:");
  //   print(e);

  // }
  runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => MoradorRepository(),
      ),
    ],
    child: MaterialApp(
      theme: ThemeData(
        // useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF00D09E),
        textTheme: GoogleFonts.poppinsTextTheme(),
        // para evitar problemas na barra de navegação
        // splashColor: Colors.transparent,
        // highlightColor: Colors.transparent,
        // hoverColor: Colors.transparent,
      ),
      home: NavegacaoPage(),
    ),
  ),
);
}
