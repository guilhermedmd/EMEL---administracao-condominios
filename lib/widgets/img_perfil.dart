import 'package:flutter/material.dart';

class Imgperfil extends StatelessWidget{
  @override
  Widget build(BuildContext content){
    return ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    "https://img.icons8.com/win10/1200/user-male-circle.jpg",
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}