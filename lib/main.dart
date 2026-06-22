import 'package:emel/models/notificacao.dart';
import 'package:emel/pages/cadastro_visitante.dart';
import 'package:emel/pages/home.dart';
import 'package:emel/pages/notificacao.dart';
import 'package:emel/pages/perfil/perfil_page.dart';
import 'package:emel/pages/splash_page.dart';
import 'package:emel/repository/morador_repository.dart';
import 'package:emel/sessionRepository/moradia_session.dart';
import 'package:emel/sessionRepository/notificacao_session.dart';
import 'package:emel/sessionRepository/usuario_session.dart';
// import 'package:emel/teste.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:emel/Controllers/visitante_controller.dart';
import 'package:emel/Controllers/visita_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('usuario');
  await Hive.openBox("notificacoes");
  await Hive.openBox("moradia");
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!
  );
  
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
        create: (_) => UsuarioSession(),
      ),      
      ChangeNotifierProvider(
        create: (_) => NotificacaoSession(),
      ),
      ChangeNotifierProvider(
        create: (_) => MoradiaSession(),
      ),
    ],
    child: MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF00D09E),
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: SplashPage()
    ),
  ),
);
}
