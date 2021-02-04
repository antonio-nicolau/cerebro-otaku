import 'package:flutter/material.dart';

alertRecordDone(int idTipoJogo) {
  String tipoJogo;

  switch (idTipoJogo) {
    case 1:
      tipoJogo = "Perguntas";
      break;
    case 2:
      tipoJogo = "Images";
      break;
  }
  return AlertDialog(
    content: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'PARABENS!!!😁',
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.0),
          Text(
            'Você completou a fase de \"$tipoJogo\"',
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
                  'Carregando próxima fase',
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
