import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otaku_game/controllers/login_controller.dart';
import 'package:otaku_game/models/player_model.dart';
import 'package:otaku_game/pages/registro_page.dart';

var _context;

Widget menuHome(context) {
  _context = context;
  return Container(
    color: Colors.transparent,
    padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 15.0),
    child: Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 90.0),
          width: 310,
          color: Colors.transparent,
          child: Card(
            color: Color.fromRGBO(0, 0, 0, 0.2),
            elevation: 5,
            child: Container(
              padding: EdgeInsets.only(top: 90.0, bottom: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Cérebro Otaku',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Um novo modo de vida ',
                    style: TextStyle(
                        fontSize: 17.0,
                        color: Colors.white70,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  _buildButtons('Jogar', Colors.green,
                      () => LoginController().isLoginSafe()),
                  SizedBox(
                    height: 15.0,
                  ),
                  _buildButtons('Cadastro', Colors.red,
                      () => Get.to(RegistroPage(false, null, null, null))),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 80,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image(
              image: AssetImage('images/naru.jpg'),
              fit: BoxFit.cover,
              width: 150,
              height: 150,
            ),
          ),
        ),
      ],
    ),
  );
}

_buildButtons(String label, Color c, Function f) {
  return Container(
    width: MediaQuery.of(_context).size.width * (50 / 100),
    decoration: BoxDecoration(
      color: c,
      borderRadius: BorderRadius.circular(50.0),
    ),
    child: FlatButton(
      onPressed: f,
      child: Text(
        label,
        style: TextStyle(color: Colors.white, fontSize: 20.0),
      ),
    ),
  );
}
