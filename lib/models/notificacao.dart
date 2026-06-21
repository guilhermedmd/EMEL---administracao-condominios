class Notificacao{
  int? id_notificacao;
  String titulo, descricao, tipo;
  bool lida;
  DateTime dataHorario;

  Notificacao(
    this.id_notificacao,
    this.titulo,
    this.descricao,
    this.tipo,
    this.lida,
    this.dataHorario
  );
  Notificacao.banco(
    this.titulo,
    this.descricao,
    this.tipo,
    this.lida,
    this.dataHorario
  );

   factory Notificacao.fromJson(Map<String, dynamic> json){
    return Notificacao.banco(
      json["id_notificacao"],
      json["titulo"],
      json["descricao"],
      json["lida"],
      json["data_horario"]
      );
}

  Map<String, dynamic> toJson() {
    return {
      "titulo": titulo,
      "descricao": descricao,
      "tipo": tipo,
      "lida": lida,
      "data_horario": dataHorario?.toIso8601String(),
    };
  }

  int get getIdNotificacao => id_notificacao ?? 00;
  String get getTitulo => titulo;
  String get getDescricao => descricao;
  String get getTipo => tipo;
  bool get getLida => lida;
  DateTime get getDataHora => getDataHora;


}