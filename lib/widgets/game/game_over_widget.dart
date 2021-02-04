import 'package:flutter/material.dart';

gameOverWidget(context, Function f) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    height: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.white54,
      borderRadius: BorderRadius.circular(30),
    ),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'FM DO JOGO😭😭',
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10.0),
        Text(
          'Você perdeu o jogo',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17.0,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
        RaisedButton(
          onPressed: () => f(),
          child: Text(
            'Novo Jogo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          color: Colors.green,
        ),
      ],
    ),
  );
}
