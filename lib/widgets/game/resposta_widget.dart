import 'package:flutter/widgets.dart';
import 'package:otaku_game/controllers/game_controller.dart';

respostaWidget(context, GameController _controller, Color cor, String resposta,
    int numRespo) {
  return GestureDetector(
    onTap: () {
      _controller.verifyAnswer(resposta, numRespo);
    },
    child: Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: cor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '$resposta',
        style: TextStyle(fontSize: 18.0),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
