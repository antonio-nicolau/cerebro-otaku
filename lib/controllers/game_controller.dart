import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otaku_game/apis/game_api.dart';
import 'package:otaku_game/controllers/profile_controller.dart';
import 'package:otaku_game/models/game_model.dart';
import 'package:otaku_game/models/player_model.dart';
import 'package:otaku_game/widgets/alerts/alert_game_over.dart';
import 'package:otaku_game/widgets/alerts/alert_record_done.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController extends GetxController {
  int position = 0, count = 0, totalLife;
  PlayerModel player;
  GameApi _api;
  List<GameModel> allQuestions;
  GameModel question;
  bool recordDone = false;
  bool hasError = false;
  bool isGameOver = false;
  int numResp = 0;
  String errorMessage;

  Timer myTimer;

  //Theses variables represent the button's color
  Color corResp1 = Colors.white;
  Color corResp2 = Colors.white;
  Color corResp3 = Colors.white;

  startTimer() {
    myTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (this.count < 30) {
        print('===');
        count++;
        update();
      } else {
        this.verifyAnswer(null, 1);
        myTimer.cancel();
      }
    });
  }

  getJogoData() async {
    this.isGameOver = false;
    player = await ProfileController.to.getPlayerData();

    if (player != null) {
      totalLife = player.life;
      _api = GameApi();

      _api.getGameData(player.id).then((response) {
        if (response != null) {
          allQuestions = response;

          if (player.life == 0) {
            isGameOver = true;
            update();
          } else {
            if (allQuestions.length > 0)
              startGame();
            else
              recordDone = true;
          }
        } else {
          hasError = true;
          errorMessage = 'Não foi possível acessar o Servidor, tente novamente';
        }
        update();
      });
    } else {
      hasError = true;
      update();
    }
  }

  Future<int> getPlayerID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('idJogador');
  }

  startGame() {
    position = 0;
    startTimer();
    sorteQuestion();
  }

  sorteQuestion() {
    if (player.life == 0) {
      if (myTimer.isActive) myTimer.cancel();
      Get.dialog(
        alertGameOver(),
      );
      Future.delayed(Duration(seconds: 1), () => gameOver());
    } else {
      if (position < allQuestions.length) {
        question = allQuestions[position];
        position++;
      } else
        _showRecordDialog();
    }
  }

  getNextLevel() async {
    final response = await _api.nextLevel(player, question, player.help);

    Get.back();

    if (response != null) {
      this.player.life++;
      allQuestions = response;

      if (response.length > 0)
        startGame();
      else {
        recordDone = true;
        if (myTimer.isActive) myTimer.cancel();
      }
    } else
      hasError = true;

    update();
  }

  _showRecordDialog() {
    myTimer.cancel();

    Get.dialog(
      alertRecordDone(question.gameMode),
    );
    Future.delayed(Duration(seconds: 1), () => getNextLevel());
  }

  verifyAnswer(String answer, int numResp) {
    if (answer == question.rightAnswer) {
      this.player.points += 10;
      changeColorButton(numResp, Colors.green);
    } else {
      this.player.life--;
      this.player.points -= 10;
      changeColorButton(numResp, Colors.red);
      updateSafeLife(
          this.player.life); // Update safe life that was bought at shop
    }

    //Wait one second and after keep the game
    Future.delayed(Duration(seconds: 1), () => keepGame());
  }

  updateSafeLife(int life) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey("life")) {
      int safeLife = preferences.getInt("life");

      if (safeLife > 0) {
        safeLife--;

        preferences.setInt("life", safeLife);
      }
    }
  }

  helpGame(int idHelp) {
    Help help = player.help[idHelp];
    int quantite = help.quantite;
    if (quantite > 0) {
      switch (idHelp) {
        case 0:
          addTime();
          sorteQuestion();
          break;
        case 1:
          addTime();
      }
      player.help[idHelp].quantite--;
    }
    update();
  }

  gameOver() async {
    final response = await _api.gameOver(question, player, player.help);
    isGameOver = true;

    Get.back();

    if (response == null)
      Get.snackbar(
          "Game over", "Fim do jogo não salvo, verifique a sua conexão");
    update();
  }

  changeColorButton(int numResp, Color cor) {
    switch (numResp) {
      case 1:
        corResp1 = cor;
        break;
      case 2:
        corResp2 = cor;
        break;
      case 3:
        corResp3 = cor;
    }
    update();
  }

  resetColorButton() {
    corResp1 = Colors.white;
    corResp2 = Colors.white;
    corResp3 = Colors.white;
    update();
  }

  keepGame() {
    resetTimer();
    resetColorButton();
    sorteQuestion();
    update();
  }

  resetTimer() {
    count = 0;
    if (!myTimer.isActive) startTimer();
    update();
  }

  addTime() {
    count = 0;
    update();
  }

  @override
  void onClose() {
    if (myTimer != null) myTimer.cancel();
    super.onClose();
  }
}
