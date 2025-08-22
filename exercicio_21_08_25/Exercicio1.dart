import 'package:flutter/material.dart';

class Exercicio1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        height: 150,
        margin: EdgeInsets.all(100),
        decoration: BoxDecoration(
          color: Colors.deepOrange,
        ),
        child: Text(
          "Hi Mom",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22
          ),
        )
      );
  }
}