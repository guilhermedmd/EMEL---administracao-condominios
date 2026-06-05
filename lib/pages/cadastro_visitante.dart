import 'package:flutter/material.dart';
import 'package:emel/widgets/default_layout.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CadastroVisitantePage extends StatefulWidget {
  const CadastroVisitantePage({super.key});

  @override
  State<CadastroVisitantePage> createState() => _CadastroVisitantePageState();
}

class _CadastroVisitantePageState extends State<CadastroVisitantePage> {
  final _nomeController = TextEditingController();
  final _cpfController = TextEditingController();
  final _senhaController = TextEditingController();
  DateTime? _dataNascimento;
  bool _carregando = false;

  Future<void> _selecionarData() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _dataNascimento = picked);
  }

  Future<void> _registrar() async {
    setState(() => _carregando = true);
    try {
      final auth = await Supabase.instance.client.auth.signUp(
        email: "${_cpfController.text.trim()}@visitante.com",
        password: _senhaController.text.trim(),
      );

      await Supabase.instance.client.from('visitante').insert({
        'id_visitante': auth.user!.id,
        'nome': _nomeController.text.trim(),
        'cpf': _cpfController.text.trim(),
        'data_nasc': _dataNascimento?.toIso8601String(),
        'senha': _senhaController.text.trim(),
      });
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro: $e')));
    } finally {
      if (mounted) setState(() => _carregando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Estilo que define o visual arredondado e colorido dos campos
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
            // Ícone de voltar e Título
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
            // Área Branca com o Formulário
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
                                _dataNascimento == null
                                    ? 'Selecione a data'
                                    : _dataNascimento.toString().split(' ')[0],
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
                        onPressed: _carregando ? null : _registrar,
                        child: _carregando
                            ? const CircularProgressIndicator()
                            : const Text(
                                "Registrar",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
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