class FormatorDatas {

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
}
