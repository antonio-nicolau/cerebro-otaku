import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otaku_game/apis/perfil_api.dart';
import 'package:otaku_game/models/player_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  ProfileApi _api;
  PlayerModel player;

  static ProfileController get to => Get.find();

  Future<PlayerModel> getPlayerData() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String user = preferences.getString("user");
      _api = ProfileApi();
      final response = await _api.getPlayerrData(user);

      if (response != null) {
        player = response;
        player = await addSafeLife(player);

        update();
        return player;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<PlayerModel> addSafeLife(PlayerModel player) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey("life")) {
      int life = preferences.getInt("life");
      if (life > 0) player.life += life;
    }
    return player;
  }

  logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("user");
    preferences.remove("senha");

    Get.back();
    Get.back();
  }
}
