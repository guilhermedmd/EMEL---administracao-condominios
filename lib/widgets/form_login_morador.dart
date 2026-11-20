import 'package:emel/controllers/moradia_controller.dart';
import 'package:emel/controllers/morador_controller.dart';
import 'package:emel/controllers/notificacaoController.dart';
import 'package:emel/models/morador.dart';
import 'package:emel/pages/navegacao_page.dart';
import 'package:emel/sessionRepository/moradia_session.dart';
import 'package:emel/sessionRepository/usuario_session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormLoginMorador extends StatefulWidget {
  const FormLoginMorador({super.key});

  @override
  State<FormLoginMorador> createState() => _FormLoginMoradorState();
}

class _FormLoginMoradorState extends State<FormLoginMorador> {
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final MoradorController _moradorController = MoradorController();
  final Notificacaocontroller _notificacaocontroller = Notificacaocontroller();
  final MoradiaController _moradiaController = MoradiaController();

  @override
  void dispose() {
    cpfController.dispose();
    senhaController.dispose();
    super.dispose();
  }

  Future<void> login(TextEditingController usuario, TextEditingController password) async {
    print("ENTROU NO LOGIN");
    try {
      final usuarioValido = await _moradorController.verificarUsuario(cpfController, senhaController);
      if (!mounted) return;
      if (usuarioValido) {
        UsuarioSession sessionUsuario = context.read<UsuarioSession>();
        int idMorador = sessionUsuario.idMorador;
        int idMoradiaFk = sessionUsuario.idMoradorFk;
        _notificacaocontroller.salvarNotificacoesRecentes(idMorador);
        _moradiaController.salvarMoradiaInfo(idMoradiaFk);
        Navigator.push(context, MaterialPageRoute(builder: (context) => NavegacaoPage()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("ERRO: login inválido!")),
        );
      }
    } catch (e, stackTrace) {
      print("ERRO CAPTURADO:");
      print(e);
      print(stackTrace);
    }
  }

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(80),
        topRight: Radius.circular(80),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: (constraints.maxHeight - 64).clamp(0.0, double.infinity),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: larguraTela * 0.1),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 24),
                            child: SizedBox(
                              width: larguraTela * 0.75,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 12, bottom: 10),
                                    child: Text(
                                      "CPF do Usuário:",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  TextField(
                                    controller: cpfController,
                                    style: const TextStyle(
                                      color: Color(0xff0E3E3E),
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(100),
                                        borderSide: BorderSide.none,
                                      ),
                                      fillColor: const Color(0xFFDFF7E2),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: larguraTela * 0.75,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 12, bottom: 10),
                                  child: Text(
                                    "Senha:",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                TextField(
                                  controller: senhaController,
                                  obscureText: true,
                                  style: const TextStyle(
                                    color: Color(0xff0E3E3E),
                                  ),
                                  decoration: InputDecoration(
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide: BorderSide.none,
                                    ),
                                    fillColor: const Color(0xffdcf4e4),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        print("BOTÃO CLICADO");
                        await login(cpfController, senhaController);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00D09E),
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 84,
                          vertical: 20,
                        ),
                      ),
                      child: const Text(
                        "Log in",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          overlayColor: WidgetStateProperty.all(Colors.transparent),
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          "Esqueceu sua senha?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff0E3E3E),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}