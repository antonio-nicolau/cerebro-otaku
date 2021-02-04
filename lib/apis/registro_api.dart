import 'package:dio/dio.dart';
import 'package:otaku_game/configuration.dart';
import 'package:otaku_game/models/player_model.dart';
import 'package:otaku_game/models/server_message.dart';

class RegistroApi {
  Future<ServerResponse> savePlayer(PlayerModel player) async {
    final params = {
      "user": player.name,
      "cla": player.cla,
      "senha": player.password,
      "image": player.image,
    };
    try {
      final response = await Dio().post(cadastroUrl, data: params);

      if (response.statusCode == 200) {
        if (response.data != null) return serverResponseFromJson(response.data);

        return ServerResponse(ok: false, message: 'Not data found');
      }
      return ServerResponse(ok: false, message: 'code diferent by 200');
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<ServerResponse> updatePlayer(
      PlayerModel player, String oldName) async {
    final params = {
      "id": player.id,
      "name": player.name,
      "cla": player.cla,
      "image": player.image,
      'oldName': oldName,
    };
    try {
      final response = await Dio().post(updatePlayerUrl, data: params);

      if (response.statusCode == 200 && response.data != null)
        return serverResponseFromJson(response.data);
    } catch (e) {
      print(e);
    }
    return null;
  }
}
