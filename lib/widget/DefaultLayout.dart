import 'package:flutter/material.dart';



class Defaultlayout extends StatelessWidget{
  // Caso precise adicionar algum outro tipo de widget personalizado adicione por aqui
    final Widget child;
    final double? heightConst;
    final Widget? floatingActionButton; 
    final Widget? bottomNavigationBar;

  const Defaultlayout({
    required this.child,
    this.heightConst,
    this.floatingActionButton,
    this.bottomNavigationBar
  });
  Widget build(BuildContext context){
    final alturaTela = MediaQuery.of(context).size.height;
    final larguraTela = MediaQuery.of(context).size.width;
     return Column(
            children: [
              Spacer(),
              Container(
                // por padrão altura do container branco é de 75% da tela
                height: alturaTela * (heightConst ?? 0.75),
                width: larguraTela,
                decoration: BoxDecoration(
                  color: Color(0xFFE3EDE8), 
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                    topRight: Radius.circular(80),
                  ),
                ),
                // CONTEÚDO DA PÁGINA ENTRARÁ BEM AQUI
                child: child,
              )
            ]
    );
    // );
  }
}