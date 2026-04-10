import 'package:flutter/material.dart';

class HelpController {
  final formKey = GlobalKey<FormState>();
  
  // Os "vigiadores" ficam aqui
  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final duvidaController = TextEditingController();

  // A função de enviar também vem para cá
  void enviarMensagem() {
    if (formKey.currentState!.validate()) {
      print("--- DADOS DO CONTROLLER ---");
      print("Nome: ${nomeController.text}");
      print("Email: ${emailController.text}");
      print("Dúvida: ${duvidaController.text}");
    }
  }

  // Gemini sugeriu, preciso entender o porquê diminui o uso de memoria.
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    duvidaController.dispose();
  }
}