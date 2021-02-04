import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:otaku_game/apis/registro_api.dart';
import 'package:otaku_game/models/player_model.dart';
import 'package:otaku_game/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistroController extends GetxController {
  var image;
  String base64Image;
  File imageFile;
  String claSelected;
  bool isLoading = false;
  final picker = ImagePicker();

  savePlayer(name, password) {
    bool valide = true;
    final player =
        PlayerModel(name: name, cla: claSelected, password: password);

    if (!(valide = isCampEmpty(name, password))) return;
    if (!(valide = validateName(name))) return;
    if (!(valide = validatePassword(password))) return;

    if (valide) {
      if (imageFile != null) {
        convertImageToBase64();
        player.image = base64Image;
      } else
        imageFile = null;

      loading(true);

      try {
        RegistroApi().savePlayer(player).then((response) {
          loading(false);
          if (response != null) {
            if (!response.ok)
              showMessageSucess(response.message);
            else
              showMessage('Cadastro', response.message);
          } else
            showMessage(
                'Cadastro', 'Servidor indisponível, verifique a sua conexão.');
        });
      } catch (e) {
        print(e);
      }

      update();
    }
  }

  updatePlayer(id, name, oldName) {
    bool valide = true;
    final player = PlayerModel(
      id: id,
      name: name,
      cla: claSelected,
    );

    if (!(valide = isCampEmpty(name, name))) return;
    if (!(valide = validateName(name))) return;

    if (valide) {
      if (imageFile != null) {
        convertImageToBase64();
        player.image = base64Image;
      } else
        imageFile = null;

      loading(true);

      try {
        RegistroApi().updatePlayer(player, oldName).then((response) {
          loading(false);
          if (response != null) {
            if (response.ok) {
              updateLoginSafe(player.name);
              Get.back();
              Get.back();
            }
            showMessage('Perfil', response.message);
          } else
            showMessage(
                'Perfil', 'Servidor indisponível, verifique a sua conexão.');
        });
      } catch (e) {
        print(e);
      }

      update();
    }
  }

  isCampEmpty(String name, String password) {
    if (name.isEmpty || password.isEmpty) {
      showMessage("Campos", "Preencha todos os campos");
      return false;
    }
    return true;
  }

  validateName(String name) {
    if (name.length > 30) {
      showMessage("Nome",
          "O nome não deve conter espaços e deve ser menor que 30 caracteres");
      return false;
    }
    return true;
  }

  validatePassword(String senha) {
    if (senha.contains(' ') || senha.length < 4) {
      showMessage("Senha",
          "A senha não poder conter espaços e deve ter 4 ou mais caracteres");
      return false;
    }
    return true;
  }

  //Open gallery and choose an image, if empty set null
  chooseImageFromGalery() async {
    picker.getImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        imageFile = File(value.path);
        image = previwImage(value);
        update();
      }
    });
  }

  previwImage(PickedFile response) {
    if (response != null) {
      if (kIsWeb) {
        return Image.network(
          response.path,
          fit: BoxFit.cover,
          width: 150,
          height: 150,
        );
      } else {
        return Image.file(
          File(response.path),
          fit: BoxFit.cover,
          width: 150,
          height: 150,
        );
      }
    } else
      return;
  }

  convertImageToBase64() {
    base64Image = base64Encode(imageFile.readAsBytesSync());
  }

  showMessageSucess(String message) {
    Get.snackbar(
      "Sucesso",
      message,
      backgroundColor: Colors.white,
      duration: Duration(seconds: 10),
      onTap: (snack) => Get.to(LoginPage()),
    );
  }

  loading(bool value) {
    isLoading = value;
    update();
  }

  getAllClas() {
    claSelected = allClas[0];
    update();
  }

  selectCla(String value) {
    claSelected = value;
    update();
  }

  showMessage(String title, String message) {
    Get.snackbar(title, message, backgroundColor: Colors.white);
  }

  get allClas {
    return [
      "Clã Uzumaki",
      "Clã Uchiha",
      "Clã Ōtsutsuki",
      "Clã Hyūga",
      "Clã Senju",
      "Clã Yamanaka",
      "Clã Kaguya",
      "Clã Nara",
    ];
  }

  updateLoginSafe(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("user", name);
  }
}
