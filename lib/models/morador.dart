class Morador {
  late int idMorador;
  late String nome, senha, cpf, email;
 
  Morador(
    this.idMorador,
    this.nome,
    this.senha,
    this.cpf,
    this.email,
  );
  
  factory Morador.fromJson(Map<String, dynamic> json) {
    return Morador(
      json['id_morador'],
      json['nome'],
      json['senha'],
      json['cpf'],
      json['email'],
    );
  }

  int get get_id => idMorador;
  String get get_nome => nome;
  String get get_senha => senha;
  String get get_cpf => cpf;
  String get get_email => email;
  
}