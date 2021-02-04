import 'dart:convert';

List<PlayerModel> scoreslFromJson(String str) => List<PlayerModel>.from(
    json.decode(str).map((x) => PlayerModel.fromJson(x)));

PlayerModel playerrModelFromJson(String str) =>
    PlayerModel.fromJson(json.decode(str));

String playerModelToJson(PlayerModel data) => json.encode(data.toJson());

class PlayerModel {
  PlayerModel({
    this.id,
    this.name,
    this.life,
    this.cla,
    this.level,
    this.points,
    this.image,
    this.password,
    this.help,
  });

  int id;
  String name;
  int life;
  String cla;
  String level;
  int points;
  String image;
  String password;
  List<Help> help;

  factory PlayerModel.fromJson(Map<String, dynamic> json) => PlayerModel(
        id: json["id"],
        name: json["name"],
        life: json["life"],
        cla: json["cla"],
        level: json["level"],
        points: json["points"],
        image: json["image"],
        help: json["help"] == null
            ? null
            : List<Help>.from(json["help"].map((x) => Help.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "life": life,
        "cla": cla,
        "level": level,
        "points": points,
        "image": image,
        "senha": password,
      };
}

class Help {
  Help({
    this.id,
    this.name,
    this.quantite,
  });

  String name;
  int id;
  int quantite;

  factory Help.fromJson(Map<String, dynamic> json) => Help(
        id: json["id"],
        name: json["name"],
        quantite: json["quantite"],
      );
}
