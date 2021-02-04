import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otaku_game/apis/login_api.dart';
import 'package:otaku_game/pages/game_page.dart';
import 'package:otaku_game/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  bool keepConnect = true;
  bool isLoading = false;
  LoginApi _api;

  changeKeepConnect(value) {
    this.keepConnect = value;
    update();
  }

  login(String name, String password) {
    _api = LoginApi();

    if (!isLoading) loading(true);

    if (isLoading) {
      _api.makeLogin(name, password).then((response) {
        if (response != null) {
          if (response.ok) {
            int playerID = response.playerID;
            saveLogin(playerID, name, password);
            Get.to(GamePage());
          } else
            showMessage("Login", response.message);
        } else
          showMessage("Login", "Login falhou, verifique a sua conexão");

        loading(false);
      });
    }
  }

  saveLogin(int playerID, String name, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("idJogador", playerID);
    preferences.setString("user", name);
    preferences.setString("senha", password);
  }

  loading(bool value) {
    isLoading = value;
    update();
  }

  isLoginSafe() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (preferences.containsKey("user") && preferences.containsKey("senha")) {
      Get.to(GamePage());
    } else {
      showMessage("Login", "Faça Login primeiro para poder jogar");
      Get.to(LoginPage());
    }
  }

  showMessage(String title, String message) {
    Get.snackbar(title, message, backgroundColor: Colors.white);
  }
}
