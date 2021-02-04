import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otaku_game/controllers/profile_controller.dart';

Future<void> alertLogout() async {
  Get.dialog(AlertDialog(
    title: Text("Logout"),
    content: SingleChildScrollView(
      child: ListBody(
        children: <Widget>[
          Text('Estás prestes a terminar sessão, deseja continuar ?'),
        ],
      ),
    ),
    actions: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            child: Text('SIM'),
            onPressed: () => ProfileController.to.logout(),
          ),
          TextButton(
            child: Text('NÃO'),
            onPressed: () => Get.back(),
          ),
        ],
      )
    ],
  ));
}
