import 'package:dio/dio.dart';
import 'package:otaku_game/configuration.dart';
import 'package:otaku_game/models/player_model.dart';

Future<List<PlayerModel>> getScores() async {
  try {
    final response = await Dio().get(scoreUrl);
    if (response.statusCode == 200) {
      if (response != null)
        return scoreslFromJson(response.toString());
      else
        print('not data');
    }
  } catch (e) {
    print(e);
  }
  return null;
}
