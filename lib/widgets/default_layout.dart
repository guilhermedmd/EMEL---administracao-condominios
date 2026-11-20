import 'package:flutter/material.dart';

class Defaultlayout extends StatelessWidget {
  final Widget child;
  final double? heightConst;
  final Widget? floatingActionButton; 

  const Defaultlayout({
    super.key,
    required this.child,
    this.heightConst,
    this.floatingActionButton,
  });

  @override 
  Widget build(BuildContext context) {
    final alturaTela = MediaQuery.of(context).size.height;
    final larguraTela = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        final alturaDesejada = alturaTela * (heightConst ?? 0.75);
        final alturaContainer = constraints.hasBoundedHeight
            ? (alturaDesejada > constraints.maxHeight
                ? constraints.maxHeight
                : alturaDesejada)
            : alturaDesejada;

        return Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: alturaContainer,
            width: constraints.hasBoundedWidth
                ? constraints.maxWidth
                : larguraTela,
            decoration: const BoxDecoration(
              color: Color(0xffF1FFF3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(80),
                topRight: Radius.circular(80),
              ),
            ),
            child: child,
          ),
        );
      },
    );
  }
}