import 'package:flutter/material.dart';
import 'package:otaku_game/models/player_model.dart';

recordeDoneWidget(PlayerModel player) {
  return Container(
      padding: EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'PARABENS !!!',
            style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.0),
          Text(
            'Você bateu o recorde 😁',
            style: TextStyle(fontSize: 22.0, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          Divider(height: 15),
          recordePerfilWidget('Jogador', player.name),
          Divider(height: 10),
          recordePerfilWidget('Clã', player.cla),
          Divider(height: 10),
          recordePerfilWidget('Pontos', player.points.toString()),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                color: Colors.yellowAccent,
                size: 35.0,
              ),
              SizedBox(width: 10.0),
              Icon(
                Icons.star,
                color: Colors.yellowAccent,
                size: 35.0,
              ),
              SizedBox(width: 10.0),
              Icon(
                Icons.star,
                color: Colors.yellowAccent,
                size: 35.0,
              ),
              SizedBox(width: 10.0),
              Icon(
                Icons.star,
                color: Colors.yellowAccent,
                size: 35.0,
              ),
            ],
          ),
          SizedBox(height: 30.0),
        ],
      ));
}

recordePerfilWidget(String label, String value) {
  return Row(
    children: [
      Text(
        '$label:',
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
      SizedBox(width: 10),
      Text(
        '$value',
        style: TextStyle(fontSize: 20.0, color: Colors.amber),
      ),
    ],
  );
}
