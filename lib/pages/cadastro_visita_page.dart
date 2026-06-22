import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


// Ajuste os caminhos abaixo conforme a sua estrutura de pastas
import 'package:emel/sessionRepository/usuario_session.dart'; 
import 'package:emel/controllers/visita_controller.dart'; 
import 'dart:convert';
import 'package:http/http.dart' as http;

class CadastroVisitaPage extends StatefulWidget {
  const CadastroVisitaPage({super.key});

  @override
  State<CadastroVisitaPage> createState() => _CadastroVisitaPageState();
}

class _CadastroVisitaPageState extends State<CadastroVisitaPage> {
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _obsController = TextEditingController();
  final TextEditingController _dataSaidaController = TextEditingController();
  // 1. Instanciando o Controller
  final VisitaController _visitaController = VisitaController();

  
  DateTime? _dataSaidaEscolhida;
  DateTime? _dataEscolhida;
  
  String? _tipoSelecionado;
  final List<String> _tiposVisitante = ['Pessoa Física', 'Prestador de Serviço'];

  // 2. Função de salvar a visita
  Future<void> _salvarVisita() async {
    final cpfDigitado = _cpfController.text.trim();
    final observacao = _obsController.text.isEmpty ? null : _obsController.text;
    final tipo = _tipoSelecionado ?? 'Pessoa Física';
    final String tipoParaOBanco = tipo == 'Prestador de Serviço' 
    ? 'Prestado de serviçosr' 
    : 'Visitante';
    
    if (_dataEscolhida == null) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("A data da visita é obrigatória!"), backgroundColor: Colors.orange),
  );
  return;
}
    if (_dataSaidaEscolhida == null) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text("A previsão de saída é obrigatória!"), backgroundColor: Colors.orange),
  );
  return;
  }

final dataEntrada = _dataEscolhida!;

    if (cpfDigitado.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("O CPF é obrigatório!"), backgroundColor: Colors.orange),
      );
      return;
    }

    try {
      // Pega o ID do morador logado via Provider
      final usuarioSession = Provider.of<UsuarioSession>(context, listen: false);
      final int idMorador = usuarioSession.idMorador;

      // Chama o Controller
      await _visitaController.cadastrarVisita(
        cpfDigitado,
        dataEntrada,
        _dataSaidaEscolhida,
        observacao,
        tipoParaOBanco,
        idMorador,
      );

      // Sucesso
      if (!mounted) return; // Boa prática no Flutter ao usar context após um await
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Visita registrada com sucesso!"), backgroundColor: Colors.green),
      );
      Navigator.pop(context);

    } catch (e) {
      // Captura o erro do Service (ex: Visitante não encontrado)
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString().replaceAll("Exception: ", "")), 
          backgroundColor: Colors.red,
        ),
      );
    }
  }

Future<void> _selecionarDataHora() async {
  // 1. Abre o calendário
  final DateTime? data = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(), // Impede de agendar no passado
    lastDate: DateTime(2100),
  );

  if (data != null) {
    // 2. Se escolheu a data, abre o relógio
    final TimeOfDay? hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (hora != null) {
      // 3. Junta tudo e atualiza a tela
      setState(() {
        _dataEscolhida = DateTime(data.year, data.month, data.day, hora.hour, hora.minute);
        
        // Coloca o texto bonito no campo (ex: 21/06/2026 14:30)
        _dataController.text = "${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year} ${hora.hour.toString().padLeft(2, '0')}:${hora.minute.toString().padLeft(2, '0')}";
      });
    }
  }
}

Future<void> _selecionarDataHoraSaida() async {
  final DateTime? data = await showDatePicker(
    context: context,
    // Se ele já escolheu a entrada, o calendário da saída abre nela. Se não, abre hoje.
    initialDate: _dataEscolhida ?? DateTime.now(), 
    firstDate: _dataEscolhida ?? DateTime.now(), // Impede de sair antes de entrar
    lastDate: DateTime(2100),
  );

  if (data != null) {
    final TimeOfDay? hora = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (hora != null) {
      setState(() {
        _dataSaidaEscolhida = DateTime(data.year, data.month, data.day, hora.hour, hora.minute);
        _dataSaidaController.text = "${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year} ${hora.hour.toString().padLeft(2, '0')}:${hora.minute.toString().padLeft(2, '0')}";
      });
    }
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF00D09E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Nova Visita",
          style: TextStyle(
            color: Color(0xFF052224),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: IconButton(
                icon: const Icon(
                  Icons.notifications_none,
                  size: 20,
                  color: Color(0xFF052224),
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 16),
        decoration: const BoxDecoration(
          color: Color(0xFFF7FDF9), // Fundo quase branco
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("Data Da Visita"),
              _buildTextField(
                controller: _dataController,
                hint: "Selecione a data",
                suffixIcon: Icons.calendar_month,
                readOnly: true,
                onTap: _selecionarDataHora
              ),
              const SizedBox(height: 20),

              _buildLabel("Data/Hora Prevista de Saída"),
              _buildTextField(
              controller: _dataSaidaController,
              hint: "Selecione a data e hora de saída",
              suffixIcon: Icons.calendar_month,
              readOnly: true,
              onTap: _selecionarDataHoraSaida, 
                ),
              const SizedBox(height: 20),

              _buildLabel("Tipo De Visitante"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5F6EC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _tipoSelecionado,
                    hint: const Text(
                      "Selecione o tipo de visitante",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF00D09E)),
                    items: _tiposVisitante.map((String tipo) {
                      return DropdownMenuItem<String>(
                        value: tipo,
                        child: Text(tipo),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _tipoSelecionado = newValue;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              _buildLabel("Nome Do Visitante"),
              _buildTextField(
                controller: _nomeController,
                hint: "Digite o nome do visitante",
              ),
              const SizedBox(height: 20),

              _buildLabel("CPF Do Visitante"),
              _buildTextField(
                controller: _cpfController,
                hint: "Digite o CPF do visitante",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              _buildLabel("Observações", color: const Color(0xFF00D09E)),
              _buildTextField(
                controller: _obsController,
                hint: "",
                maxLines: 5,
              ),
              const SizedBox(height: 40),

              Center(
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _salvarVisita, 
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00D09E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Registrar Visita",
                      style: TextStyle(
                        color: Color(0xFF052224),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para as labels dos campos
  Widget _buildLabel(String text, {Color color = const Color(0xFF052224)}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  // Widget auxiliar para os campos de texto
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    IconData? suffixIcon,
    int maxLines = 1,
    bool readOnly = false,
    VoidCallback? onTap,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        filled: true,
        fillColor: const Color(0xFFE5F6EC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: const Color(0xFF00D09E))
            : null,
      ),
    );
  }
}