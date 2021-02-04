import 'package:flutter/material.dart';
import 'package:otaku_game/apis/scores_api.dart';
import 'package:otaku_game/models/player_model.dart';
import 'package:otaku_game/configuration.dart';
import 'package:otaku_game/widgets/navigation_bar_widget.dart';
import 'package:otaku_game/widgets/progressbar.dart';
import 'package:otaku_game/widgets/refresh_page_widget.dart';

class ScoresPage extends StatefulWidget {
  @override
  _ScoresPageState createState() => _ScoresPageState();
}

class _ScoresPageState extends State<ScoresPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/blackover.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar:
            myNavigationBar(context, Colors.white, Colors.transparent),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                margin: EdgeInsets.only(top: 50.0),
                padding: EdgeInsets.fromLTRB(15, 30, 15, 20),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      color: Colors.amber,
                      child: Text(
                        'Melhores Jogadores',
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    FutureBuilder(
                        future: getScores(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.waiting ||
                              snapshot.connectionState ==
                                  ConnectionState.none) {
                            return progressBar('Carregando Scores, aguarde...');
                          } else {
                            if (snapshot.hasData) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.shortestSide,
                                child: ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {
                                      PlayerModel model = snapshot.data[index];
                                      return pontuacaoWidget(model, index);
                                    }),
                              );
                            } else {
                              return Container(
                                margin: EdgeInsets.only(top: 50),
                                padding: EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: refreshPageWidg(context, () {
                                  setState(() {});
                                }),
                              );
                            }
                          }
                        })
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  pontuacaoWidget(PlayerModel model, int index) {
    Color background = Colors.amber[200];
    Color textColor = Colors.black;

    if (index == 0) {
      background = Colors.amber;
    }
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      padding: EdgeInsets.fromLTRB(15.0, 20.0, 10.0, 10.0),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('$host/img/${model.image}'),
            onBackgroundImageError: (exception, stackTrace) =>
                Image.asset('images/person.png'),
          ),
          Column(
            children: [
              Text(
                '${model.name}',
                style: TextStyle(
                  color: textColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                '${model.cla}',
                style: TextStyle(
                  color: textColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Text(
            '${model.points}',
            style: TextStyle(
                color: textColor, fontSize: 23.0, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
