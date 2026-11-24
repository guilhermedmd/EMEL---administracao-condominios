import 'dart:async';
import 'package:flutter/material.dart';
import 'package:emel/controllers/visita_controller.dart';
import 'package:emel/utils/formator_datas.dart';
import 'package:emel/widgets/default_layout.dart';
import 'package:emel/widgets/confirmar_entrada.dart';

class AcompanhamentoVisitaPage extends StatefulWidget {
  final int idVisita;
  final int idVisitante;
  final String nomeMorador;
  final DateTime? dataChegada;
  final DateTime? dataEntrada;
  final int? tempoAtendimento;
  final String? statusAtendimento;
  final VoidCallback? onAtualizar;

  final int tempoLimiteExpiracaoSegundos;

  const AcompanhamentoVisitaPage({
    super.key,
    required this.idVisita,
    required this.idVisitante,
    this.nomeMorador = 'Morador',
    this.dataChegada,
    this.dataEntrada,
    this.tempoAtendimento,
    this.statusAtendimento,
    this.onAtualizar,
    this.tempoLimiteExpiracaoSegundos = 1200,
  });

  @override
  State<AcompanhamentoVisitaPage> createState() =>
      _AcompanhamentoVisitaPageState();
}

class _AcompanhamentoVisitaPageState extends State<AcompanhamentoVisitaPage> {
  final VisitaController _visitaController = VisitaController();

  int get _limiteExpiracao => widget.tempoLimiteExpiracaoSegundos;

  Timer? _timer;
  DateTime? _horaChegada;
  Duration _tempoDecorrido = Duration.zero;

  bool _chegadaRegistrada = false;
  bool _entradaConfirmada = false;
  bool _isProcessando = false;
  bool _isExpirando = false;
  bool _isPopupAberto = false;
  String? _statusBanco;

  @override
  void initState() {
    super.initState();
    _restaurarEstadoInicial();
  }

  @override
  void didUpdateWidget(covariant AcompanhamentoVisitaPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dataChegada != widget.dataChegada ||
        oldWidget.dataEntrada != widget.dataEntrada ||
        oldWidget.tempoAtendimento != widget.tempoAtendimento ||
        oldWidget.statusAtendimento != widget.statusAtendimento ||
        oldWidget.tempoLimiteExpiracaoSegundos != widget.tempoLimiteExpiracaoSegundos) {
      _restaurarEstadoInicial();
    }
  }

  void _restaurarEstadoInicial() {
    _statusBanco = widget.statusAtendimento;

    final dataEntrada =
        FormatadorDatas().converterParaDataLocal(widget.dataEntrada);
    final dataChegada =
        FormatadorDatas().converterParaDataLocal(widget.dataChegada);

    // Caso 1: Entrada já foi confirmada anteriormente
    if (dataEntrada != null) {
      _chegadaRegistrada = true;
      _entradaConfirmada = true;
      if (widget.tempoAtendimento != null && widget.tempoAtendimento! >= 0) {
        _tempoDecorrido = Duration(seconds: widget.tempoAtendimento!);
      } else if (dataChegada != null) {
        final diff = dataEntrada.difference(dataChegada);
        _tempoDecorrido = diff.isNegative ? Duration.zero : diff;
      }
      return;
    }

    // Caso 2: Chegada já foi registrada anteriormente e está aguardando atendimento
    if (dataChegada != null) {
      _chegadaRegistrada = true;
      _horaChegada = dataChegada;
      final diff = DateTime.now().difference(dataChegada);
      _tempoDecorrido = diff.isNegative ? Duration.zero : diff;

      // Se já atingiu ou superou o limite de expiração, encerra automaticamente
      if (_tempoDecorrido.inSeconds >= _limiteExpiracao) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _encerrarPorExpiracao();
          }
        });
      } else {
        _iniciarTimer();
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _iniciarTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted || _horaChegada == null) return;
      final diff = DateTime.now().difference(_horaChegada!);
      final novoTempo = diff.isNegative ? Duration.zero : diff;

      if (novoTempo.inSeconds >= _limiteExpiracao) {
        _timer?.cancel();
        setState(() {
          _tempoDecorrido = novoTempo;
        });
        _encerrarPorExpiracao();
        return;
      }

      setState(() {
        _tempoDecorrido = novoTempo;
      });
    });
  }

  Future<void> _registrarChegada() async {
    setState(() => _isProcessando = true);

    try {
      await _visitaController.registrarChegada(
        widget.idVisita,
        widget.idVisitante,
      );

      if (!mounted) return;

      setState(() {
        _chegadaRegistrada = true;
        _horaChegada = DateTime.now();
        _tempoDecorrido = Duration.zero;
      });

      _iniciarTimer();
      widget.onAtualizar?.call();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFFEA2A24),
            content: Text('Erro ao registrar chegada: $e'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessando = false);
      }
    }
  }

  Future<void> _abrirConfirmacaoEntrada() async {
    String? codigoDigitado;
    _isPopupAberto = true;
    try {
      codigoDigitado = await ConfirmarEntradaPopup.mostrarPopUp(context);
    } finally {
      _isPopupAberto = false;
    }

    if (codigoDigitado == null || codigoDigitado.length < 4 || _entradaConfirmada) {
      return;
    }

    setState(() => _isProcessando = true);

    try {
      // 1. Valida se o código digitado confere com o do banco
      final bool codigoCorreto = await _visitaController.validarCodigoEntrada(
        widget.idVisita,
        widget.idVisitante,
        codigoDigitado,
      );

      if (!codigoCorreto) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Color(0xFFEA2A24),
              content: Text(
                'Código incorreto! Solicite o código de 4 dígitos informado pelo síndico.',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            ),
          );
        }
        return;
      }

      // 2. Se o código estiver correto, grava data_entrada e aciona Trigger 2
      final resultado = await _visitaController.registrarEntrada(
        widget.idVisita,
        widget.idVisitante,
      );

      _timer?.cancel();

      if (mounted) {
        setState(() {
          _entradaConfirmada = true;
          if (resultado != null) {
            final int? segundosBanco = resultado['tempo_atendimento'] as int?;
            if (segundosBanco != null) {
              _tempoDecorrido = Duration(seconds: segundosBanco);
            }
            _statusBanco = resultado['status_atendimento']?.toString();
          }
        });
        widget.onAtualizar?.call();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFFEA2A24),
            content: Text('Erro ao registrar entrada: $e'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessando = false);
      }
    }
  }

  // Encerra o cronômetro automaticamente ao atingir 20 minutos (1200 segundos) sem código
  Future<void> _encerrarPorExpiracao() async {
    if (_isExpirando || _entradaConfirmada) return;
    _isExpirando = true;
    _timer?.cancel();

    // Fecha o modal de confirmação de código caso esteja aberto
    if (_isPopupAberto && mounted) {
      Navigator.of(context).pop();
      _isPopupAberto = false;
    }

    setState(() {
      _entradaConfirmada = true;
      _statusBanco = 'Expirado';
      if (_tempoDecorrido.inSeconds < _limiteExpiracao) {
        _tempoDecorrido = Duration(seconds: _limiteExpiracao);
      }
    });

    try {
      final resultado = await _visitaController.encerrarVisitaPorExpiracao(
        widget.idVisita,
        widget.idVisitante,
      );

      if (!mounted) return;

      setState(() {
        if (resultado != null) {
          final int? segundosBanco = resultado['tempo_atendimento'] as int?;
          if (segundosBanco != null) {
            _tempoDecorrido = Duration(seconds: segundosBanco);
          }
          _statusBanco =
              resultado['status_atendimento']?.toString() ?? 'Expirado';
        }
      });

      final minutos = _limiteExpiracao ~/ 60;
      final textoLimite = minutos > 0 ? '$minutos minuto(s)' : '$_limiteExpiracao segundos';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color(0xFFEA2A24),
          content: Text(
            'Tempo limite de $textoLimite atingido. O atendimento foi encerrado como Expirado.',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      );
    } catch (e) {
      print('Erro ao registrar expiração de atendimento no banco: $e');
    } finally {
      _isExpirando = false;
    }
  }

  String get _statusTexto {
    if (_statusBanco != null) {
      switch (_statusBanco!.toLowerCase().trim()) {
        case 'rapido':
          return 'Rápido';
        case 'ok':
          return 'Ok';
        case 'demorado':
          return 'Demorado';
        case 'expirado':
          return 'Expirado';
        default:
          return _statusBanco!;
      }
    }

    final segundos = _tempoDecorrido.inSeconds;
    if (segundos >= _limiteExpiracao) return 'Expirado';
    if (segundos <= 120 && _limiteExpiracao > 120) return 'Rápido';
    if (segundos <= 300 && _limiteExpiracao > 300) return 'Ok';
    return 'Demorado';
  }

  Color get _statusCor {
    final status = _statusTexto.toLowerCase();
    if (status == 'rápido' || status == 'rapido') {
      return const Color(0xFF00D294);
    }
    if (status == 'ok') {
      return const Color(0xFFFF9119);
    }
    return const Color(0xFFEA2A24); // Demorado ou Expirado
  }

  @override
  Widget build(BuildContext context) {
    final totalSegundos =
        _tempoDecorrido.isNegative ? 0 : _tempoDecorrido.inSeconds;
    final totalMinutos = totalSegundos ~/ 60;
    final segs = totalSegundos % 60;

    final minutosDisplay = totalMinutos > 99 ? 99 : totalMinutos;
    final minutos = minutosDisplay.toString().padLeft(2, '0');
    final segundos = segs.toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: const Color(0xFF00D294),
      body: Defaultlayout(
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
    if (_isProcessando) {
      return const Center(
        child: CircularProgressIndicator(
          color: Color(0xFF00D294),
        ),
      );
    }

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
                  color: _statusTexto == 'Demorado' || _statusTexto == 'Expirado'
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
      onPressed: _registrarChegada,
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
