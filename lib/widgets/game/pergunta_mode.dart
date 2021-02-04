import 'package:flutter/material.dart';
import 'package:otaku_game/controllers/game_controller.dart';
import 'package:otaku_game/models/game_model.dart';
import 'package:otaku_game/widgets/game/help_widget.dart';
import 'package:otaku_game/widgets/game/resposta_widget.dart';
import 'package:otaku_game/widgets/game/timer_widget.dart';

perguntaMode(context, GameController _controller, GameModel model) {
  return Column(
    children: [
      timeWidget(_controller.count),
      SizedBox(height: 40.0),
      Container(
        padding: EdgeInsets.only(bottom: 30.0),
        child: Text(
          '${model.question}',
          style: TextStyle(
              fontSize: 22.0, fontWeight: FontWeight.w600, color: Colors.white),
        ),
      ),
      Container(
        child: Column(
          children: [
            respostaWidget(context, _controller, _controller.corResp1,
                model.firstAnswer, 1),
            SizedBox(
              height: 20.0,
            ),
            respostaWidget(
                context, _controller, _controller.corResp2, model.secAnswer, 2),
            SizedBox(
              height: 20,
            ),
            respostaWidget(context, _controller, _controller.corResp3,
                model.thirtAnswer, 3),
          ],
        ),
      ),
      SizedBox(height: 40.0),
      helpWidget(_controller),
    ],
  );
}
