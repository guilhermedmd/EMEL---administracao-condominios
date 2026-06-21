import 'package:emel/repository/notificacao_repository.dart';

class NotificacoesService {

    NotificacaoRepository notificacaoRepository = NotificacaoRepository();

    Future<void> getNotificacoesRecentes(int idMorador) async{
      // retorna as notificações mais recentes
      await notificacaoRepository.notificacoesRecentes(idMorador);
    }

    Future<(List<Map<String, dynamic>>, List<Map<String, dynamic>>)> mostrarTodasNotificacoes(int idMorador) async{
      // retorna todas as notificações organizados com base no mês atual em uma tupla
      List<Map<String, dynamic>> listaNotificacoes = await notificacaoRepository.getNotificacoes(idMorador);
      DateTime dataAtual = DateTime.now();
      List<Map<String, dynamic>> esteMes = [];
      List<Map<String, dynamic>> anteriores = [];
      // for(var n in listaNotificacoes){
      //   print("${n.keys} ${n.values}");
      // }
      // Separação dos valores em duas listas
      // para notificações do mês atual e anteriores
      for(var n in listaNotificacoes){
        var dataNot = n["data_horario"].toString().split("-");
          if(dataNot[1].replaceAll("0", "") == dataAtual.month.toString()){
            esteMes.add(n);
          }else{
            anteriores.add(n);
          }
      }
      return (esteMes, anteriores);
    }
}