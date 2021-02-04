import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otaku_game/apis/shope_api.dart';
import 'package:otaku_game/controllers/profile_controller.dart';
import 'package:otaku_game/models/player_model.dart';
import 'package:otaku_game/models/shope_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopeController extends GetxController {
  PlayerModel player;
  bool hasError = false, noLogin = false;
  List<ShopeModel> shopeItens;
  ShopeApi _api = ShopeApi();

  getData() async {
    try {
      player = await ProfileController.to.getPlayerData();
      if (player != null) {
        final response = await _api.getShopeData();
        if (response != null) {
          shopeItens = response;
        } else
          hasError = true;
      } else {
        noLogin = true;
      }
    } catch (e) {
      hasError = true;
    }
    update();
  }

  addPlayerItem(ShopeModel shope) async {
    if (player.points >= shope.pointNecessary) {
      if (player != null) {
        int newPoint = player.points - shope.pointNecessary;
        final response = await _api.buyItemPlayer(player.id, shope, newPoint);

        if (response != null) {
          if (response.ok) {
            if (shope.id == 1)
              buyLife(shope.quantite); // The life's bought is safe locale

            player.points = newPoint;

            showSnackbar("Loja", response.message);
          } else
            showSnackbar("Erro", response.message);
        } else
          showSnackbar("Erro na conexão",
              "Não foi possível acessar o servidor, verifique a sua conexão e tente novamente");
      }
    } else
      showSnackbar("Loja", "Dinheiro insuficiente");
  }

  buyLife(int quantidade) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey("life")) {
      final life = quantidade + preferences.getInt("life");
      preferences.setInt("life", life);
    } else
      preferences.setInt("life", quantidade);
  }

  void showSnackbar(String title, String message) {
    Get.snackbar(title, message, backgroundColor: Colors.white);
  }
}
