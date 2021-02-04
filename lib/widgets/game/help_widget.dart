import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:otaku_game/controllers/game_controller.dart';
import 'package:otaku_game/models/player_model.dart';

helpWidget(GameController _controller) {
  List<Help> help = _controller.player.help;
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            _controller.helpGame(0);
          },
          child: Container(
            child: Row(
              children: [
                Text(
                  'Pular Pergunta',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.white),
                ),
                SizedBox(width: 10.0),
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _controller.player.help[0].quantite > 0
                        ? Colors.grey[300]
                        : Colors.red,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: GetBuilder<GameController>(
                    init: _controller,
                    builder: (_) => Text(
                      '${help[0].quantite}',
                      style: TextStyle(
                        fontSize: 18,
                        color: _controller.player.help[0].quantite > 0
                            ? Colors.green
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            _controller.helpGame(1);
          },
          child: Container(
            child: Row(
              children: [
                Text(
                  'Mais tempo',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(width: 10.0),
                Container(
                  width: 40,
                  height: 40,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _controller.player.help[1].quantite > 0
                        ? Colors.grey[300]
                        : Colors.red,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: GetBuilder<GameController>(
                    init: _controller,
                    builder: (_) => Text(
                      '${help[1].quantite}',
                      style: TextStyle(
                        fontSize: 18,
                        color: _controller.player.help[1].quantite > 0
                            ? Colors.green
                            : Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
