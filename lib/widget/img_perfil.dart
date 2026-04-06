import 'package:flutter/material.dart';

class img_perfil extends StatelessWidget{
  Widget build(BuildContext content){
    return ClipRRect(
                  borderRadius: BorderRadius.circular(100), // deixa circular
                  child: Image.network(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsctbx6qPptmGizR2EgK2jDWOgMTIAszz4FA&s",
        width: 150,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}