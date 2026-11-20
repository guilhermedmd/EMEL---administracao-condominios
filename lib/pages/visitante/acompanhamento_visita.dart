import 'dart:async';
import 'package:flutter/material.dart';
// Ajuste os imports abaixo conforme o caminho das pastas no seu projeto:
import 'package:emel/widgets/default_layout.dart';
import 'package:emel/widgets/confirmar_entrada.dart';

class AcompanhamentoVisitaPage extends StatefulWidget {
  final String nomeMorador;

  const AcompanhamentoVisitaPage({
    super.key,
    this.nomeMorador = 'Daniela Martins',
  });

  @override
  State<AcompanhamentoVisitaPage> createState() =>
      _AcompanhamentoVisitaPageState();
}

class _AcompanhamentoVisitaPageState extends State<AcompanhamentoVisitaPage> {
  Timer? _timer;
  DateTime? _horaChegada;
  Duration _tempoDecorrido = Duration.zero;

  bool _chegadaRegistrada = false;
  bool _entradaConfirmada = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _iniciarCronometro() {
    setState(() {
      _chegadaRegistrada = true;
      _horaChegada = DateTime.now();
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || _horaChegada == null) return;
      setState(() {
        _tempoDecorrido = DateTime.now().difference(_horaChegada!);
      });
    });
  }

  Future<void> _abrirConfirmacaoEntrada() async {
    final String? codigoDigitado =
        await ConfirmarEntradaPopup.mostrarPopUp(context);

    // Como ainda não está ligado ao banco, qualquer código de 4 dígitos confirma a tela
    if (codigoDigitado != null && codigoDigitado.length == 4) {
      _timer?.cancel();
      setState(() {
        _entradaConfirmada = true;
      });
    }
  }

  String get _statusTexto {
    final segundos = _tempoDecorrido.inSeconds;
    if (segundos <= 120) return 'Rápido';
    if (segundos <= 300) return 'Ok';
    return 'Demorado';
  }

  Color get _statusCor {
    final segundos = _tempoDecorrido.inSeconds;
    if (segundos <= 120) return const Color(0xFF00D294);
    if (segundos <= 300) return const Color(0xFFFF9119);
    return const Color(0xFFEA2A24);
  }

  @override
  Widget build(BuildContext context) {
    final minutos =
        _tempoDecorrido.inMinutes.remainder(60).toString().padLeft(2, '0');
    final segundos =
        _tempoDecorrido.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: const Color(0xFF00D294),
      body: Stack(
        children: [
          // Cabeçalho verde com botão voltar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 12, top: 8),
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ),

          // Container principal usando o Defaultlayout do projeto
          Defaultlayout(
            heightConst: 0.84,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              child: Column(
                children: [
                  // Pílula título "Visita"
                  Container(
                    width: 220,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00D294),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      'Visita',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D3B36),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // Card "Residência de: ..."
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF0D3B36),
                        ),
                        children: [
                          const TextSpan(text: 'Residência de: '),
                          TextSpan(
                            text: widget.nomeMorador,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Card do Cronômetro
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 26,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: const Color(0xFFA8E6C1),
                        width: 1.2,
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Tempo Até Entrar No Residencial',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D3B36),
                          ),
                        ),
                        const SizedBox(height: 28),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildDigitoCard(minutos[0]),
                            const SizedBox(width: 8),
                            _buildDigitoCard(minutos[1]),
                            const SizedBox(width: 10),
                            _buildDoisPontos(),
                            const SizedBox(width: 10),
                            _buildDigitoCard(segundos[0]),
                            const SizedBox(width: 8),
                            _buildDigitoCard(segundos[1]),
                          ],
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),

                  const SizedBox(height: 44),

                  // Área dinâmica inferior (Botões ou Status Final)
                  _buildRodapeAcao(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDigitoCard(String digito) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 0.82,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFF9CE5B4),
              width: 1,
            ),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0AD698),
                Color(0xFFCDE7DC),
              ],
            ),
          ),
          child: Text(
            digito,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0D3B36),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDoisPontos() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Color(0xFF0D3B36),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: 8,
          height: 8,
          decoration: const BoxDecoration(
            color: Color(0xFF0D3B36),
            shape: BoxShape.circle,
          ),
        ),
      ],
    );
  }

  Widget _buildRodapeAcao() {
    // Estado 3: Entrada confirmada -> exibe pílula com status
    if (_entradaConfirmada) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: const Color(0xFFA8E6C1),
            width: 1.2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Tempo Entrada:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0D3B36),
              ),
            ),
            const SizedBox(width: 14),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: _statusCor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _statusTexto,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _statusTexto == 'Demorado'
                      ? Colors.white
                      : const Color(0xFF0D3B36),
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Estado 2: Cronômetro ativo -> botão azul "registrar entrada"
    if (_chegadaRegistrada) {
      return ElevatedButton(
        onPressed: _abrirConfirmacaoEntrada,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF649CF0),
          foregroundColor: const Color(0xFF0D3B36),
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 14),
          elevation: 0,
        ),
        child: const Text(
          'registrar entrada',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }

    // Estado 1: Inicial -> botão verde "registrar chegada"
    return ElevatedButton(
      onPressed: _iniciarCronometro,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF09D697),
        foregroundColor: const Color(0xFF0D3B36),
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 14),
        elevation: 0,
      ),
      child: const Text(
        'registrar chegada',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}