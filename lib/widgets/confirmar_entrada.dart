import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConfirmarEntradaPopup {
  static Future<String?> mostrarPopUp(BuildContext context) {
    final TextEditingController codigoController = TextEditingController();
    String? mensagemErro;

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              contentPadding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Informe o código indicado pelo\nsindico',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF0D3B36),
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: codigoController,
                    keyboardType: TextInputType.number,
                    maxLength: 4,
                    textAlign: TextAlign.center,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 8,
                      color: Color(0xFF0D3B36),
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: const Color(0xFFF3FFF6),
                      contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color(0xFF9CE5B4),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Color(0xFF00D294),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  if (mensagemErro != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      mensagemErro!,
                      style: const TextStyle(
                        color: Color(0xFFEA2A24),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final codigo = codigoController.text.trim();
                            if (codigo.length < 4) {
                              setStateDialog(() {
                                mensagemErro = 'Digite os 4 dígitos do código.';
                              });
                              return;
                            }
                            Navigator.of(context).pop(codigo);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00D294),
                            foregroundColor: const Color(0xFF0D3B36),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Confirmar',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(null),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEA2A24),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}