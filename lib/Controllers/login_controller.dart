import 'package:emel/mock/mock_usuario.dart';
import 'package:emel/models/morador.dart';
import 'package:flutter/material.dart';

class LoginController {
  static Morador? verificarUsuario(TextEditingController usuarioController, TextEditingController passwordController){
    String usuario = usuarioController.text;
    String password = passwordController.text;
   if(MockUsuario().moradores.containsKey(usuario)){
    if(MockUsuario().moradores[usuario]!.get_password == password){
        var morador = MockUsuario().moradores[usuario];
        return morador;
      }
      return null;
   }
     return null;
  }
}


