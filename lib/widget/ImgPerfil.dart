import 'package:flutter/material.dart';

class Imgperfil extends StatelessWidget{
  Widget build(BuildContext content){
    return ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    "https://cdn-icons-png.flaticon.com/512/14022/14022382.png",
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}