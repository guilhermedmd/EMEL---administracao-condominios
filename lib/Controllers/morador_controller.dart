import 'package:emel/mock/mock_usuario.dart';
import 'package:emel/models/morador.dart';
import 'package:emel/service/morador_service.dart';
import 'package:flutter/material.dart';

class MoradorController {

  static final MoradorService moradorService = MoradorService();

    Future<bool> verificarUsuario(TextEditingController cpfController, TextEditingController senhaController)async{
    String cpfLogin = cpfController.text;
    String senhaLogin = senhaController.text;
    Morador? morador = await moradorService.validarLogin(cpfLogin, senhaLogin);
    if (morador != null){
      return true;
    } 
    return false;
  }
}