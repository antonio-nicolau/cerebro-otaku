import 'dart:convert';

List<GameModel> gameModelFromJson(String str) =>
    List<GameModel>.from(json.decode(str).map((x) => GameModel.fromJson(x)));

class GameModel {
  GameModel({
    this.questionID,
    this.animeID,
    this.question,
    this.arquivo,
    this.gameMode,
    this.anime,
    this.level,
    this.ptNecessario,
    this.firstAnswer,
    this.secAnswer,
    this.thirtAnswer,
    this.rightAnswer,
  });

  String question;
  String arquivo;
  String anime;
  String level;
  int questionID;
  int animeID;
  int gameMode;
  int ptNecessario;
  String firstAnswer;
  String secAnswer;
  String thirtAnswer;
  String rightAnswer;

  factory GameModel.fromJson(Map<String, dynamic> json) => GameModel(
        questionID: json['idPergunta'],
        animeID: json['idAnime'],
        question: json['pergunta'],
        arquivo: json['arquivo'],
        gameMode: json['idTipoJogo'],
        anime: json['anime'],
        level: json['Nivel'],
        ptNecessario: json['ptNecessario'],
        firstAnswer: json['primResposta'],
        secAnswer: json['segResposta'],
        thirtAnswer: json['tercResposta'],
        rightAnswer: json['respCerta'],
      );
}
