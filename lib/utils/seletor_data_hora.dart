import 'package:flutter/material.dart';

Future<DateTime?> selecionarDataHora({
  required BuildContext context,
  DateTime? valorInicial,
  DateTime? dataMinima,
  DateTime? dataMaxima,
}) async {
  final agora = DateTime.now();
  final minima = DateUtils.dateOnly(dataMinima ?? DateTime(2000));
  final maxima = DateUtils.dateOnly(dataMaxima ?? DateTime(2100));

  // Garante que a data inicial nunca seja menor que a mínima (evita travamento)
  DateTime inicial = DateUtils.dateOnly(valorInicial ?? agora);
  if (inicial.isBefore(minima)) inicial = minima;
  if (inicial.isAfter(maxima)) inicial = maxima;

  // 1. Seleciona Dia, Mês e Ano
  final DateTime? dataEscolhida = await showDatePicker(
    context: context,
    initialDate: inicial,
    firstDate: minima,
    lastDate: maxima,
  );

  if (dataEscolhida == null || !context.mounted) return null;

  // 2. Seleciona o horário no formato 24h
  final horaBase = valorInicial ?? agora;
  final TimeOfDay? horaEscolhida = await showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: horaBase.hour, minute: horaBase.minute),
    builder: (context, child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      );
    },
  );

  if (horaEscolhida == null) return null;

  // 3. Retorna data e hora combinadas
  return DateTime(
    dataEscolhida.year,
    dataEscolhida.month,
    dataEscolhida.day,
    horaEscolhida.hour,
    horaEscolhida.minute,
  );
}