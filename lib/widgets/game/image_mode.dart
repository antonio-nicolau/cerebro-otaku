import 'package:flutter/material.dart';
import 'package:otaku_game/configuration.dart';
import 'package:otaku_game/controllers/game_controller.dart';
import 'package:otaku_game/models/game_model.dart';
import 'package:otaku_game/widgets/alerts/alert_profile_image.dart';
import 'package:otaku_game/widgets/game/help_widget.dart';
import 'package:otaku_game/widgets/game/resposta_widget.dart';
import 'package:otaku_game/widgets/game/timer_widget.dart';

imagemMode(context, GameController _controller, GameModel model) {
  return Column(
    children: [
      timeWidget(_controller.count),
      SizedBox(height: 20.0),
      GestureDetector(
        onTap: () => alertProfileImage(context, "", imageHost + model.arquivo),
        child: Container(
          width: 300,
          height: 250,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              '${imageHost + model.arquivo}',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '${model.question}',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20.0, color: Colors.white),
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
