class Visitante {
  int? id_visitante;
  String nome, cpf, email, senha;
  DateTime? dataNasc;

  Visitante(
    this.id_visitante,
    this.nome,
    this.cpf,
    this.email,
    this.senha
  );

// Construtor para enviar os dados para o banco
  Visitante.banco(
    this.nome,
    this.cpf,
    this.email,
    this.senha,
    this.dataNasc
  );
  factory Visitante.fromJson(Map<String, dynamic> json){
    return Visitante(
      json["id_visitante"],
      json["nome"],
      json["cpf"],
      json["email"],
      json["senha"]
      );
  }
  Map<String, dynamic> toJson() {
    return {
      "nome": nome,
      "cpf": cpf,
      "email": email,
      "senha": senha,
      "data_nasc": dataNasc?.toIso8601String(),
    };
  }

  int get getIdVisitante => id_visitante ?? 0000;
  String get getNomeVisitante => nome;
  String get getCpfVisitante => cpf;
  String get getEmailVisitante => email;
  String get getSenhaVisitante => senha;

}