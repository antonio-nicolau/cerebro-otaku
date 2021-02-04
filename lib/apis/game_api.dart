import 'package:dio/dio.dart';
import 'package:otaku_game/configuration.dart';
import 'package:otaku_game/models/game_model.dart';
import 'package:otaku_game/models/player_model.dart';
import 'package:otaku_game/models/server_message.dart';

class GameApi {
  Future<List<GameModel>> getGameData(int idJogador) async {
    try {
      final response = await Dio().get(jogoUrl + '/' + idJogador.toString());

      if (response.statusCode == 200 && response.data != null)
        return gameModelFromJson(response.toString());
      else
        return null;
    } catch (e) {}
    return null;
  }

  Future<List<GameModel>> nextLevel(
      PlayerModel player, GameModel game, List<Help> help) async {
    try {
      final params = {
        'animeId': game.animeID,
        'gameMode': game.gameMode,
        'playerId': player.id,
        'points': player.points,
        'helpChangeQuestion': help[0].quantite,
        'helpMoreTime': help[1].quantite,
      };

      final response = await Dio().post(nextLevelUrl, data: params);

      if (response.statusCode == 200 && response.data != null) {
        return gameModelFromJson(response.toString());
      }
    } catch (e) {}
    return null;
  }

  Future<ServerResponse> gameOver(
      GameModel game, PlayerModel player, List<Help> help) async {
    try {
      final params = {
        'animeId': game.animeID,
        'gameMode': game.gameMode,
        'playerId': player.id,
        'points': player.points,
        'helpChangeQuestion': help[0].quantite,
        'helpMoreTime': help[1].quantite,
      };

      final response = await Dio().post(gameOverlUrl, data: params);

      if (response.statusCode == 200 && response.data != null) {
        return serverResponseFromJson(response.toString());
      }
    } catch (e) {}
    return null;
  }
}
