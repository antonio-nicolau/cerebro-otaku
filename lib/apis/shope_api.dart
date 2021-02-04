import 'package:dio/dio.dart';
import 'package:otaku_game/configuration.dart';
import 'package:otaku_game/models/server_message.dart';
import 'package:otaku_game/models/shope_model.dart';

class ShopeApi {
  Future<List<ShopeModel>> getShopeData() async {
    try {
      final response = await Dio().get(lojaUrl);
      if (response.statusCode == 200) {
        if (response != null) return shopeModelFromJson(response.toString());
      }
    } catch (e) {
      print("Error: " + e);
    }
    return null;
  }

  Future<ServerResponse> buyItemPlayer(
      int playerID, ShopeModel shope, int newPointPlayer) async {
    try {
      final params = {
        'idJogador': playerID,
        'idLoja': shope.id,
        'quantidade': shope.quantite,
        'novoPonto': newPointPlayer
      };

      final response = await Dio().post(urlUpdateItem, data: params);
      if (response.statusCode == 200) {
        if (response != null)
          return serverResponseFromJson(response.data.toString());
      }
    } catch (e) {
      print(e);
    }
    return null;
  }
}
