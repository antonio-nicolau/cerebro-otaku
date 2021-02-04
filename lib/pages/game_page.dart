import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otaku_game/controllers/game_controller.dart';
import 'package:otaku_game/controllers/profile_controller.dart';
import 'package:otaku_game/models/player_model.dart';
import 'package:otaku_game/widgets/appbars/appbar_widget.dart';
import 'package:otaku_game/widgets/game/image_mode.dart';
import 'package:otaku_game/widgets/game/pergunta_mode.dart';
import 'package:otaku_game/widgets/game/game_over_widget.dart';
import 'package:otaku_game/widgets/navigation_bar_widget.dart';
import 'package:otaku_game/models/game_model.dart';
import 'package:otaku_game/widgets/progressbar.dart';
import 'package:otaku_game/widgets/game/record_done_widget.dart';
import 'package:otaku_game/widgets/refresh_page_widget.dart';

class GamePage extends StatelessWidget {
  PlayerModel player;
  GameController _controller = GameController();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileController());

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/blackover.jpg'),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.transparent),
          actions: [
            GetBuilder<GameController>(
              init: _controller,
              builder: (_) {
                return appBar(context, _.player);
              },
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        bottomNavigationBar:
            myNavigationBar(context, Colors.white, Colors.transparent),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Center(
            child: GetBuilder<GameController>(
              initState: (_) {
                _controller.getJogoData();
              },
              init: _controller,
              builder: (_) {
                if (_.allQuestions == null && !_.hasError) {
                  return progressBar('Carregando jogo...');
                } else {
                  if (!_.hasError) {
                    if (_.isGameOver)
                      return gameOverWidget(
                          context, () => _controller.getJogoData());
                    else
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        margin: EdgeInsets.only(top: 10.0, bottom: 30.0),
                        color: Color.fromRGBO(0, 0, 0, 0.4),
                        padding: EdgeInsets.fromLTRB(15, 10.0, 15.0, 20.0),
                        child: !_.recordDone
                            ? selecionaModoJogo(_.question, context)
                            : recordeDoneWidget(_.player),
                      );
                  } else {
                    return refreshPageWidg(context, () {
                      _controller.hasError = false;
                      _controller.update();
                      _controller.getJogoData();
                    });
                  }
                }
              },
            ),
          )),
        ),
      ),
    );
  }

  selecionaModoJogo(GameModel model, context) {
    int gameMode = model.gameMode;

    switch (gameMode) {
      case 1:
        return perguntaMode(context, _controller, model);
      case 2:
        return imagemMode(context, _controller, model);
    }
  }
}
