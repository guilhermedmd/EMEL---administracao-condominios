import 'package:flutter/material.dart';



class Defaultlayout extends StatelessWidget{
    final Widget child;
    final String title;
    final double? heightConst;
    final double? widthConst;

  const Defaultlayout({
    required this.child,
    required this.title,
    this.heightConst,
    this.widthConst
  });
  Widget build(BuildContext context){
    final alturaTela = MediaQuery.of(context).size.height;
    final larguraTela = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Center(child: Text(title)), backgroundColor: Colors.transparent),
      body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
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
    ));
  }
}