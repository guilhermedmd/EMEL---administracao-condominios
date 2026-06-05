class Visitante {
  int id_visitante;
  String nome, cpf, email, senha;

  Visitante(
    this.id_visitante,
    this.nome,
    this.cpf,
    this.email,
    this.senha
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

  int get getIdVisitante => id_visitante;
  String get getNomeVisitante => nome;
  String get getCpfVisitante => cpf;
  String get getEmailVisitante => email;
  String get getSenhaVisitante => senha;

}