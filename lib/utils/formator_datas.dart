import 'package:intl/intl.dart';

class FormatadorDatas {

  DateTime? converterParaDataLocal(dynamic dataBanco) {
    if (dataBanco == null) return null;
    if (dataBanco is DateTime) {
      final data = dataBanco.isUtc ? dataBanco.toLocal() : dataBanco;
      final agora = DateTime.now();
      if (!data.isAfter(agora)) return data;
      final dataUtcConvertida = DateTime.utc(
        data.year,
        data.month,
        data.day,
        data.hour,
        data.minute,
        data.second,
        data.millisecond,
        data.microsecond,
      ).toLocal();
      if (!dataUtcConvertida.isAfter(agora)) return dataUtcConvertida;
      return agora;
    }

    final str = dataBanco.toString().trim();
    if (str.isEmpty) return null;

    final strIso = str.replaceAll(' ', 'T');
    final parsed = DateTime.tryParse(strIso);
    if (parsed == null) return null;

    if (parsed.isUtc || strIso.endsWith('Z') || strIso.contains('+')) {
      final local = parsed.toLocal();
      final agora = DateTime.now();
      return local.isAfter(agora) ? agora : local;
    }

    final agora = DateTime.now();
    if (!parsed.isAfter(agora)) {
      return parsed;
    }

    // Caso o timestamp tenha sido gerado por now() do servidor PostgreSQL (UTC) e salvo sem 'Z':
    final parsedComoUtc = DateTime.tryParse("${strIso}Z")?.toLocal();
    if (parsedComoUtc != null && !parsedComoUtc.isAfter(agora)) {
      return parsedComoUtc;
    }

    // Se ainda assim estiver no futuro (por clock skew entre dispositivo e servidor), limita a agora
    return agora;
  }

  DateTime paraDateTime(String texto) {
  // Converte "15:10 - 23/06/2026" em um objeto DateTime
  final partes = texto.split('-'); // ["15:10 ", " 23/06/2026"]
  final horaMinuto = partes[0].trim().split(':'); // ["15", "10"]
  final diaMesAno = partes[1].trim().split('/'); // ["23", "06", "2026"]

  return DateTime(
    int.parse(diaMesAno[2]), // ano (2026)
    int.parse(diaMesAno[1]), // mês (06)
    int.parse(diaMesAno[0]), // dia (23)
    int.parse(horaMinuto[0]), // hora (15)
    int.parse(horaMinuto[1]), // minuto (10)
  );
}
  String formatarData(String? dataBanco) {
    if (dataBanco == null) return '';
    try {
      DateTime? data = converterParaDataLocal(dataBanco) ?? DateTime.tryParse(dataBanco);
      if (data == null) return '';
      // Formata para: "12:43 - 13/12/2026"
      String hora = DateFormat('HH:mm').format(data);
      String dataNew = DateFormat('dd/MM/yyyy').format(data);
      return "$hora - $dataNew";
    } catch (e) {
      return '';
    }
  }
}
