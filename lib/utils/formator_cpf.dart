class FormatadorCpf{

  String? limparEValidarCpf(String cpf) {
  final apenasNumeros = cpf.replaceAll(RegExp(r'\D'), '');

  if (apenasNumeros.length != 11) {
    return null;
  }

  return apenasNumeros;
  }
}