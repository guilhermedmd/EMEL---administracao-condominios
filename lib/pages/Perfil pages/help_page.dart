import 'package:flutter/material.dart';
import 'package:emel/widget/default_layout.dart';
import 'package:emel/Controllers/help_controller.dart';


class HelpPage extends StatelessWidget {
  HelpPage({super.key});
  final _formKey = GlobalKey<FormState>();
  final controller = HelpController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF00D09E),
        elevation: 0,
        title: const Text("Help and Contact"),
      ),
      body: Defaultlayout(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. O texto descritivo que você queria
                const Text(
                  "Este aplicativo foi desenvolvido para a gestão simplificada de condomínios, facilitando o acesso ao suporte.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 30),

                // 2. O título do formulário (com "message" corrigido)
                const Text(
                  "Send a message to EMEL",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // 3. Campo Nome
                TextFormField(
                  controller: controller.nomeController,
                  validator: (v) => v!.isEmpty ? 'Erro' : null,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 15),

                // 4. Campo Email
                TextFormField(
                  controller: controller.emailController,
                  validator: (v) => v!.isEmpty ? 'Erro' : null,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),

                // 5. Campo Dúvida (How can we help you?)
                TextFormField(
                  controller: controller.duvidaController,
                  validator: (v) => v!.isEmpty ? 'Erro' : null,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Envie seu dúvida e entraremos em contato',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
                const SizedBox(height: 25),

                // 6. Botão de Enviar
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                    controller.enviarMensagem();
                    print("Mensagem enviada!");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00D09E),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("SEND"),
                  ),
                ),
              ], // Aqui fecha o children da Column
            ), // Aqui fecha a Column
          ), // Aqui fecha o Form
        ), // Aqui fecha o SingleChildScrollView
      ), // Aqui fecha o Defaultlayout
    ); // Aqui fecha o Scaffold
  }
}
