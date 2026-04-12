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

    return Column(
      children: [
        const Spacer(),
        Container(
          height: alturaTela * (heightConst ?? 0.75),
          width: larguraTela,
          decoration: const BoxDecoration(
            color: Color(0xFFf4fcf4), 
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(80),
              topRight: Radius.circular(80),
            ),
          ),
          child: child,
        ),
      ],
    );
  }
}