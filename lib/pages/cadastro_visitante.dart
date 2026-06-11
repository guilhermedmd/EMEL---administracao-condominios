import 'package:emel/controllers/visitante_controller.dart';
import 'package:flutter/material.dart';
import 'package:emel/widgets/default_layout.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Está com as partes estranhas do supabase removidas
class CadastroVisitantePage extends StatefulWidget {
  const CadastroVisitantePage({super.key});

  @override
  State<CadastroVisitantePage> createState() => _CadastroVisitantePageState();
}

class _CadastroVisitantePageState extends State<CadastroVisitantePage> {
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _senhaController = TextEditingController();
  final _emailController = TextEditingController();
  final _dataNascimentoController = TextEditingController();

  DateTime? _dataNascimento;

  Future<void> _selecionarData() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _dataNascimento = picked;

        _dataNascimentoController.text =
            "${picked.day.toString().padLeft(2, '0')}/"
            "${picked.month.toString().padLeft(2, '0')}/"
            "${picked.year}";
      });
    }
  }

  Future<void> cadastrarVisitante() async {
    try {
      if (_dataNascimento == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Selecione a data de nascimento')),
        );
        return;
      }

      await VisitanteController().cadastrarVisitante(
        _nomeController.text,
        _cpfController.text,
        _emailController.text,
        _senhaController.text,
        _dataNascimento!,
      );

      _nomeController.clear();
      _cpfController.clear();
      _emailController.clear();
      _senhaController.clear();
      _dataNascimentoController.clear();

      setState(() {
        _dataNascimento = null;
      });

      print("Cadastro realizado");
    } catch (e) {
      print("ERRO: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputDecoration = InputDecoration(
      filled: true,
      fillColor: const Color(0xFFD4E2DB),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      labelStyle: const TextStyle(
        color: Color(0xFF2D5D48),
        fontWeight: FontWeight.bold,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFF00D09E),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 40.0),
              child: Text(
                "Cadastrar",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Defaultlayout(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 20.0,
                  ),
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: _nomeController,
                        decoration: inputDecoration.copyWith(
                          labelText: 'Nome Do Visitante',
                          hintText: 'Digite o nome do visitante',
                        ),
                      ),

                      const SizedBox(height: 20),

                      InkWell(
                        onTap: _selecionarData,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4E2DB),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _dataNascimentoController.text == ""
                                    ? 'Selecione a data de nascimento'
                                    : _dataNascimentoController.text
                                          .toString()
                                          .split(' ')[0],
                                style: const TextStyle(color: Colors.black54),
                              ),
                              const Icon(
                                Icons.calendar_today,
                                color: Color(0xFF2D5D48),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        controller: _cpfController,
                        decoration: inputDecoration.copyWith(
                          labelText: 'CPF Do Visitante',
                          hintText: 'Digite o CPF',
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        controller: _emailController,
                        decoration: inputDecoration.copyWith(
                          labelText: 'E-mail',
                          hintText: 'Digite seu e-mail',
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        controller: _senhaController,
                        decoration: inputDecoration.copyWith(
                          labelText: 'Senha',
                          hintText: 'Digite sua senha',
                        ),
                        obscureText: true,
                      ),

                      const SizedBox(height: 40),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00D09E),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () async {
                          // implementar depois
                          await cadastrarVisitante();
                        },
                        child: const Text(
                          "Registrar",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
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
