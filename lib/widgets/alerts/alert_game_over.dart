import 'package:flutter/material.dart';

alertGameOver() {
  return AlertDialog(
    content: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'FM DO JOGO😭😭',
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.0),
          Text(
            'Você perdeu o jogo, tente novamente',
            style: TextStyle(),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30.0),
          Center(
            child: Column(
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 15.0),
                Text(
                  'Salvando jogo, aguarde...',
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
