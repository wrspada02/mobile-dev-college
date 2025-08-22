import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Exercicio2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Hello World!",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 22
            ),
          ),
          SizedBox(
            child: Container(
              child: Text(
                "SizedBox"
              ),
            ),
          ),
          TextButton(
            onPressed: () {}, 
            style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(
                Colors.blueAccent
              )
            ),
            child: Text(
              "A button",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          )
        ],
      ),
    );
  }
}
