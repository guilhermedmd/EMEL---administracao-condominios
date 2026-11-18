class Morador {
  late int idMorador, idMoradiaFk;
  late String nome, senha, cpf, email;
  late bool permissao;
 
  Morador(
    this.idMorador,
    this.nome,
    this.senha,
    this.cpf,
    this.email,
    this.permissao,
    this.idMoradiaFk
  );
  
  factory Morador.fromJson(Map<String, dynamic> json) {
    return Morador(
      json['id_morador'],
      json['nome'],
      json['senha'],
      json['cpf'],
      json['email'],
      json['permissao'],
      json['id_moradia_fk'],
    );
  }

  int get get_id => idMorador;
  String get get_nome => nome;
  String get get_senha => senha;
  String get get_cpf => cpf;
  String get get_email => email;
  bool get get_permissao => permissao;
  int get get_idMoradia => idMoradiaFk;
}