import 'package:dio/dio.dart';
import 'package:otaku_game/models/player_model.dart';
import 'package:otaku_game/models/server_message.dart';
import 'package:otaku_game/configuration.dart';

class ProfileApi {
  Future<PlayerModel> getPlayerrData(String user) async {
    try {
      final response = await Dio().get(perfilUrl + '/' + user);
      if (response != null && response.statusCode == 200)
        return playerrModelFromJson(response.data.toString());
    } catch (e) {}
    return null;
  }

  Future<ServerResponse> resetPlayerLife(int idPlayer) async {
    try {
      final response =
          await Dio().post(resetPlayerLifeUrl, data: {'idPlayer': idPlayer});
      if (response != null && response.statusCode == 200)
        return serverResponseFromJson(response.data.toString());
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
}
