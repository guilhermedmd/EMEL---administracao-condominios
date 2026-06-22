import 'package:emel/service/notificacoes_service.dart';

class Notificacaocontroller {
  NotificacoesService notificacoesService = NotificacoesService();

  Future<void> salvarNotificacoesRecentes(int idMorador)async{
    await notificacoesService.getNotificacoesRecentes(idMorador);
  }

  Future<(List<Map<String, dynamic>>, List<Map<String, dynamic>>)> todasNotificacoes(int idMorador)async{
    final dados = await notificacoesService.mostrarTodasNotificacoes(idMorador);
    return dados;

  }

  Future<int> buscarQtdeEntregas(int idMorador)async{
    int qtdeEntregas = await notificacoesService.buscarQtdeEntregas(idMorador);
    return qtdeEntregas;
  }

}