class Visita {
  int? idVisita;
  DateTime dataHoraEntrada;
  DateTime? dataHoraSaida;
  String? observacao;
  String tipo;
  int idMorador;

  Visita(
    this.idVisita,
    this.dataHoraEntrada,
    this.dataHoraSaida,
    this.observacao,
    this.tipo,
    this.idMorador
  );

  Map<String,dynamic> toJson(){

    return {
      "data_hora_entrada": dataHoraEntrada.toIso8601String(),
      "data_hora_saida": dataHoraSaida?.toIso8601String(),
      "observacao": observacao,
      "tipo": tipo,
      "id_morador_fk":idMorador
    };
  }
}